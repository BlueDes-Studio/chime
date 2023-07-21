import 'package:chime/components/molecules/landingpagetemplate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LandingPage3 extends StatelessWidget {
  static String route = "app/landing-page/Page3";

  const LandingPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return LandingPageTemplate(
      children: [
        Positioned(
          top: 100,
          child: SvgPicture.asset("assets/liquid-bg3.svg"),
        ),
        Positioned(
          top: 100,
          child: SvgPicture.asset("assets/data-trends.svg"),
        ),
        Positioned(
          top: 480,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: const Text(
              "Track your attendance in real time!",
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
              "Visualise your present as well as future predicted attendance.",
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
