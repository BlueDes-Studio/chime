import 'package:chime/components/atoms/customized_input.dart';
import 'package:chime/components/molecules/landingpageanimatable.dart';
import 'package:chime/config/colorscheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_shadow/simple_shadow.dart';

enum SignupInputPage {
  enterEmailPage,
  enterOTPPage,
  enterStudentDetailsPage,
}

List<Widget> generateInputFieldsForSignup(SignupInputPage signupInputPage) {
  switch (signupInputPage) {
    case SignupInputPage.enterEmailPage:
      return [
        const CustomizedInputComponent(
          label: "Email",
          inputHint: "Eg. chimesupport@gmail.com",
        ),
        Container(
          height: 15,
        ),
      ];

    case SignupInputPage.enterOTPPage:
      return [
        const CustomizedInputComponent(
          label: "High Security Password",
          inputHint: "OTP sent to your email",
        ),
        Container(
          height: 15,
        ),
      ];
    case SignupInputPage.enterStudentDetailsPage:
      return [
        const CustomizedInputComponent(
          label: "Username",
          inputHint: "username",
        ),
        Container(
          height: 15,
        ),
        const CustomizedInputComponent(
          label: "Roll No.",
          inputHint: "Eg. 21CS8001",
        ),
        Container(
          height: 15,
        ),
      ];
  }
}

String generateButtonTitleForSignup(SignupInputPage signupInputPage) {
  switch (signupInputPage) {
    case SignupInputPage.enterEmailPage:
      return "Send OTP";
    case SignupInputPage.enterOTPPage:
      return "Verify OTP";
    case SignupInputPage.enterStudentDetailsPage:
      return "Continue";
  }
}

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

class AuthScreen extends StatefulWidget {
  static String route = "/app/auth";
  const AuthScreen({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    duration: const Duration(milliseconds: 400),
    vsync: this,
  );

  late final Animation<double> _offsetAnimationUpperLeft = Tween<double>(
    begin: -550,
    end: -300,
  ).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ),
  );

  late final Animation<double> _offsetAnimationScreenText = Tween<double>(
    begin: -150,
    end: 0,
  ).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ),
  );

  late final Animation<double> _offsetAnimationForm = Tween<double>(
    begin: MediaQuery.of(context).size.height,
    end: 280,
  ).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ),
  );

  late final Animation<double> _offsetAnimationCenter = Tween<double>(
    begin: MediaQuery.of(context).size.height,
    end: -200,
  ).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ),
  );

  late final Animation<double> _offsetAnimationCenter2 = Tween<double>(
    begin: MediaQuery.of(context).size.height,
    end: -30,
  ).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ),
  );

  late final Animation<double> _offsetAnimationLower = Tween<double>(
    begin: MediaQuery.of(context).size.height,
    end: 170,
  ).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ),
  );

  String screenName = "";
  Widget formComponent = Container();

  double opacityLevelBg1 = 1.0;
  double opacityLevelBg2 = 0.0;
  double opacityLevelBg3 = 0.0;
  double opacityLevelBg4 = 0.0;

  late double screenWidth;

  PageController scrollController = PageController();

  @override
  void initState() {
    super.initState();
    _animationController.addListener(() {
      setState(() {});
    });

    scrollController.addListener(() {
      double offset = scrollController.offset;

      screenWidth = MediaQuery.of(context).size.width;

      setState(() {
        if (offset > 0 && offset < screenWidth) {
          double ratio = offset / screenWidth;
          opacityLevelBg1 = 1 - ratio;
          opacityLevelBg2 = ratio;
        } else if (offset > screenWidth && offset < screenWidth * 2) {
          double ratio = (offset - screenWidth) / screenWidth;
          opacityLevelBg2 = 1 - ratio;
          opacityLevelBg3 = ratio;
        } else if (offset > screenWidth * 2 && offset < screenWidth * 3) {
          double ratio = (offset - screenWidth * 2) / screenWidth;
          opacityLevelBg3 = 1 - ratio;
          opacityLevelBg4 = ratio;
        }
      });
    });
  }

  void swapBetweenLoginAndSignup() {
    _animationController.reverse();
    Future.delayed(const Duration(milliseconds: 500), () {
      _animationController.forward();
      setState(() {
        switch (screenName) {
          case "Sign Up":
            screenName = "Login";
            break;
          case "Login":
            screenName = "Sign Up";
            break;
        }
      });
    });
  }

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
                left: 0,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: screenWidth,
                        height: MediaQuery.of(context).size.height,
                        color: const Color(0xffE3EBFF),
                        child: Stack(
                          children: [
                            //linear gradient on top view
                            Positioned(
                              top: 0,
                              child: Container(
                                width: screenWidth,
                                height: 180,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color(0xff863DFF),
                                      Color(0xffD3C5FF),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 100,
                              child: Opacity(
                                opacity: opacityLevelBg1,
                                child: SvgPicture.asset(
                                  "assets/liquid-bg1.svg",
                                  width: screenWidth,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 100,
                              child: Opacity(
                                opacity: opacityLevelBg2,
                                child: SvgPicture.asset(
                                  "assets/liquid-bg2.svg",
                                  width: screenWidth,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 100,
                              child: Opacity(
                                opacity: opacityLevelBg3,
                                child: SvgPicture.asset(
                                  "assets/liquid-bg3.svg",
                                  width: screenWidth,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 100,
                              child: Opacity(
                                opacity: opacityLevelBg4,
                                child: SvgPicture.asset(
                                  "assets/liquid-bg4.svg",
                                  width: screenWidth,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 120,
                              child: SizedBox(
                                width: screenWidth,
                                height: 600,
                                //all the scrollable items
                                child: PageView(
                                  controller: scrollController,
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    LandingPageAnimatableComponent(
                                      opacity: opacityLevelBg1,
                                      mainAsset: "assets/student-stress.svg",
                                      heading:
                                          "keeping track of attendance is a hassle!",
                                      description: "we all know the 75% scene",
                                      customDescriptionWidget: Container(),
                                    ),
                                    LandingPageAnimatableComponent(
                                      opacity: opacityLevelBg2,
                                      mainAsset: "assets/study-abroad.svg",
                                      heading:
                                          "What if its as simple as few click?",
                                      description:
                                          "just one tap from notification screen and your attendance is tracked!",
                                      assetTopSpace: 0,
                                      headingTopSpace: 30,
                                      customDescriptionWidget: Container(),
                                    ),
                                    LandingPageAnimatableComponent(
                                      opacity: opacityLevelBg3,
                                      mainAsset: "assets/data-trends.svg",
                                      heading:
                                          "Track your attendance in real time!",
                                      description:
                                          "Visualise your present as well as future predicted attendance.",
                                      assetTopSpace: 0,
                                      headingTopSpace: 10,
                                      customDescriptionWidget: Container(),
                                    ),
                                    LandingPageAnimatableComponent(
                                      opacity: opacityLevelBg4,
                                      mainAsset: "assets/helpful-sign.svg",
                                      heading:
                                          "We Got you! login to never miss your attendance goals",
                                      assetTopSpace: 0,
                                      headingTopSpace: 10,
                                      customDescriptionWidgetEnabled: true,
                                      customDescriptionWidget: Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: SizedBox(
                                          width: screenWidth,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              TextButton(
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          chimePurple),
                                                  fixedSize:
                                                      MaterialStateProperty.all(
                                                          const Size(150, 30)),
                                                  shape: MaterialStateProperty.all(
                                                      const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                  )),
                                                ),
                                                onPressed: () {
                                                  _animationController
                                                      .forward();
                                                  setState(() {
                                                    screenName = "Login";
                                                  });
                                                },
                                                child: const Text(
                                                  "Login",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              TextButton(
                                                style: ButtonStyle(
                                                  fixedSize:
                                                      MaterialStateProperty.all(
                                                          const Size(150, 30)),
                                                  shape:
                                                      MaterialStateProperty.all(
                                                    const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10)),
                                                      side: BorderSide(
                                                        color: chimePurple,
                                                        width: 2,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  _animationController
                                                      .forward();
                                                  setState(() {
                                                    screenName = "Signup";
                                                  });
                                                },
                                                child: const Text(
                                                  "Sign Up",
                                                  style: TextStyle(
                                                    color: chimePurple,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
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
              Positioned(
                top: _offsetAnimationCenter.value,
                left: -60,
                child: SimpleShadow(
                  color: const Color(0xff873EFF),
                  opacity: 0.4, // Default: 0.5
                  offset: const Offset(1, 1), // Default: Offset(2, 2)
                  sigma: 5,
                  child: RepaintBoundary(
                    child: SvgPicture.asset(
                      "assets/auth-center.svg",
                    ),
                  ), // Default: 2
                ),
              ),
              Positioned(
                top: _offsetAnimationCenter2.value,
                left: -60,
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
                left: _offsetAnimationUpperLeft.value,
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
              Positioned(
                top: _offsetAnimationLower.value,
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
                left: _offsetAnimationScreenText.value,
                child: SizedBox(
                  height: 100,
                  width: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          _animationController.reverse();
                        },
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
                      Padding(
                        padding: const EdgeInsets.only(left: 35),
                        child: Text(
                          screenName,
                          style: const TextStyle(
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
                top: _offsetAnimationForm.value,
                child: SizedBox(
                  width: screenWidth,
                  height: 400,
                  child: screenName == "Login"
                      ? LoginFormComponent(
                          swapScreen: swapBetweenLoginAndSignup,
                        )
                      : SignupFormComponent(
                          swapScreen: swapBetweenLoginAndSignup,
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
