import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:chime/config/colorscheme.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:chime/components/atoms/customized_input.dart';

class LoginFormComponent extends StatelessWidget {
  final void Function() swapScreen;
  const LoginFormComponent({
    super.key,
    required this.swapScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomizedInputComponent(
          label: "Username or Email",
          inputHint: "Eg. chimesupport@gmail.com",
        ),
        Container(
          height: 15,
        ),
        const CustomizedInputComponent(
          label: "Password",
          inputHint: "password",
        ),
        Container(
          height: 20,
        ),
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(chimePurple),
            fixedSize: MaterialStateProperty.all(const Size(150, 30)),
            shape: MaterialStateProperty.all(const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            )),
          ),
          onPressed: () {},
          child: const Text(
            "Login",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              const RoundedRectangleBorder(
                side: BorderSide.none,
              ),
            ),
          ),
          onPressed: () {},
          child: const Text(
            "Having trouble with login?",
            style: TextStyle(
              color: chimePurple,
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
                        color: Color(0xff474747),
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
                "Don’t have and account yet?",
                style: TextStyle(
                  fontFamily: "Inter",
                ),
              ),
              GestureDetector(
                onTap: swapScreen,
                child: const Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Text(
                    "Signup now",
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
