import 'package:chime/components/molecules/landingpagetemplate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LandingPage2 extends StatelessWidget {
  static String route = "app/landing-page/Page2";

  const LandingPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return LandingPageTemplate(
      children: [
        Positioned(
          top: 100,
          child: SvgPicture.asset("assets/liquid-bg2.svg"),
        ),
        Positioned(
          top: 120,
          child: SvgPicture.asset("assets/study-abroad.svg"),
        ),
        Positioned(
          top: 480,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: const Text(
              "What if its as simple as few click?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Positioned(
          top: 580,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: const Text(
              "just one tap from notification screen and your attendance is tracked!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
