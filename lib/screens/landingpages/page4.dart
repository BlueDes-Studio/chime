import 'package:chime/components/molecules/landingpagetemplate.dart';
import 'package:chime/config/colorscheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LandingPage4 extends StatelessWidget {
  static String route = "app/landing-page/Page4";

  const LandingPage4({super.key});

  @override
  Widget build(BuildContext context) {
    return LandingPageTemplate(
      children: [
        Positioned(
          top: 100,
          child: SvgPicture.asset("assets/liquid-bg4.svg"),
        ),
        Positioned(
          top: 100,
          child: SvgPicture.asset("assets/helpful-sign.svg"),
        ),
        Positioned(
          top: 480,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: const Text(
              "We Got you! login to never miss your attendance goals",
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
          bottom: 50,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(chimePurple),
                    fixedSize: MaterialStateProperty.all(const Size(150, 30)),
                    shape:
                        MaterialStateProperty.all(const RoundedRectangleBorder(
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
                    fixedSize: MaterialStateProperty.all(const Size(150, 30)),
                    shape:
                        MaterialStateProperty.all(const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            side: BorderSide(
                              color: chimePurple,
                              width: 2,
                            ))),
                  ),
                  onPressed: () {},
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
        )
      ],
    );
  }
}
