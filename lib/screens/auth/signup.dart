import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:chime/config/colorscheme.dart';
import 'package:simple_shadow/simple_shadow.dart';

import 'auth.dart';

class SignupFormComponent extends StatefulWidget {
  final void Function() swapScreen;
  const SignupFormComponent({
    super.key,
    required this.swapScreen,
  });

  @override
  State<SignupFormComponent> createState() => _SignupFormComponentState();
}

class _SignupFormComponentState extends State<SignupFormComponent> {
  SignupInputPage signupPageType = SignupInputPage.enterEmailPage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...generateInputFieldsForSignup(signupPageType),
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(chimePurple),
            fixedSize: MaterialStateProperty.all(const Size(150, 30)),
            shape: MaterialStateProperty.all(const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            )),
          ),
          onPressed: () {
            setState(() {
              switch (signupPageType) {
                case SignupInputPage.enterEmailPage:
                  signupPageType = SignupInputPage.enterOTPPage;
                  break;
                case SignupInputPage.enterOTPPage:
                  signupPageType = SignupInputPage.enterStudentDetailsPage;
                  break;
                case SignupInputPage.enterStudentDetailsPage:
                  signupPageType = SignupInputPage.enterEmailPage;
                  break;
              }
            });
          },
          child: Text(
            generateButtonTitleForSignup(signupPageType),
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        RepaintBoundary(
          child: SvgPicture.asset(
            "assets/auth-or-line.svg",
          ),
        ),
        Container(
          height: 20,
        ),
        SimpleShadow(
          opacity: 0.2, // Default: 0.5
          offset: const Offset(1, 1), // Default: Offset(2, 2)
          sigma: 2,
          child: InkWell(
            onTap: () {},
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 25,
                ),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Image.asset("assets/google-logo.png",
                        width: 20, height: 20),
                    const SizedBox(width: 12),
                    const Text(
                      'Continue with google',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: "Inter",
                        color: darkGrey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Already have an account!",
                style: TextStyle(
                  fontFamily: "Inter",
                ),
              ),
              GestureDetector(
                onTap: widget.swapScreen,
                child: const Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: chimePurple,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
