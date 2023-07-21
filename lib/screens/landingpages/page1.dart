import 'package:chime/components/molecules/landingpagetemplate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LandingPage1 extends StatelessWidget {
  static String route = "app/landing-page/Page1";

  const LandingPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return LandingPageTemplate(
      children: [
        Positioned(
          top: 100,
          child: SvgPicture.asset("assets/liquid-bg1.svg"),
        ),
        Positioned(
          top: 160,
          child: SvgPicture.asset("assets/student-stress.svg"),
        ),
        Positioned(
          top: 480,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: const Text(
              "keeping track of attendance is a hassle!",
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
              "we all know the 75% scene",
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
