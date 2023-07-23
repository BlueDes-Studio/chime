import 'package:chime/config/colorscheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:chime/components/atoms/customized_input.dart';

class LoginScreen extends StatefulWidget {
  static String route = "app/auth/login";
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);

  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(-0.05, 0.0),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticIn,
  ));

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: SizedBox(
          width: screenWidth,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: -15,
                child: SimpleShadow(
                  color: const Color(0xff873EFF),
                  opacity: 0.4, // Default: 0.5
                  offset: const Offset(1, 1), // Default: Offset(2, 2)
                  sigma: 5,
                  child: RepaintBoundary(
                    child: SvgPicture.asset(
                      "assets/auth-center2.svg",
                    ),
                  ), // Default: 2
                ),
              ),
              Positioned(
                top: -265,
                left: -300,
                child: SlideTransition(
                  position: _offsetAnimation,
                  child: SimpleShadow(
                    color: const Color(0xff873EFF),
                    opacity: 0.4, // Default: 0.5
                    offset: const Offset(1, 1), // Default: Offset(2, 2)
                    sigma: 5,
                    child: RepaintBoundary(
                      child: SvgPicture.asset(
                        "assets/auth-upper-left.svg",
                      ),
                    ), // Default: 2
                  ),
                ),
              ),
              Positioned(
                top: 170,
                left: -130,
                child: SimpleShadow(
                  color: const Color(0xff873EFF),
                  opacity: 0.8, // Default: 0.5
                  offset: const Offset(5, 5), // Default: Offset(2, 2)
                  sigma: 15,
                  child: RepaintBoundary(
                    child: SvgPicture.asset(
                      "assets/auth-lower.svg",
                    ),
                  ), // Default: 2
                ),
              ),
              Positioned(
                top: 35,
                child: SizedBox(
                  height: 100,
                  width: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 15,
                          color: Color(0xff9C60FF),
                        ),
                        label: const Text(
                          "Back",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff9C60FF),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 35),
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w600,
                            fontSize: 35,
                            color: Color(0xff474747),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 280,
                child: SizedBox(
                  width: screenWidth,
                  height: 400,
                  child: Column(
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
                          backgroundColor:
                              MaterialStateProperty.all(chimePurple),
                          fixedSize:
                              MaterialStateProperty.all(const Size(150, 30)),
                          shape: MaterialStateProperty.all(
                              const RoundedRectangleBorder(
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
                          "Having trouble login in?",
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
                      const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don’t have and account yet?",
                              style: TextStyle(
                                fontFamily: "Inter",
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Text(
                                "Signup now",
                                style: TextStyle(
                                  color: chimePurple,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
