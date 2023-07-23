import 'package:chime/components/molecules/landingpageanimatable.dart';
import 'package:chime/config/colorscheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LandingPages extends StatefulWidget {
  static String route = "app/landing-page";

  const LandingPages({super.key});

  @override
  State<LandingPages> createState() => LandingPagesState();
}

class LandingPagesState extends State<LandingPages> {
  double opacityLevelBg1 = 1.0;
  double opacityLevelBg2 = 0.0;
  double opacityLevelBg3 = 0.0;
  double opacityLevelBg4 = 0.0;

  late double screenWidth;

  PageController scrollController = PageController();

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
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
                          heading: "keeping track of attendance is a hassle!",
                          description: "we all know the 75% scene",
                          customDescriptionWidget: Container(),
                        ),
                        LandingPageAnimatableComponent(
                          opacity: opacityLevelBg2,
                          mainAsset: "assets/study-abroad.svg",
                          heading: "What if its as simple as few click?",
                          description:
                              "just one tap from notification screen and your attendance is tracked!",
                          assetTopSpace: 0,
                          headingTopSpace: 30,
                          customDescriptionWidget: Container(),
                        ),
                        LandingPageAnimatableComponent(
                          opacity: opacityLevelBg3,
                          mainAsset: "assets/data-trends.svg",
                          heading: "Track your attendance in real time!",
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  TextButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              chimePurple),
                                      fixedSize: MaterialStateProperty.all(
                                          const Size(150, 30)),
                                      shape: MaterialStateProperty.all(
                                          const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
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
                                      fixedSize: MaterialStateProperty.all(
                                          const Size(150, 30)),
                                      shape: MaterialStateProperty.all(
                                        const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          side: BorderSide(
                                            color: chimePurple,
                                            width: 2,
                                          ),
                                        ),
                                      ),
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
    );
  }
}
