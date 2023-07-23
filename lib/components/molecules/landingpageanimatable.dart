import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LandingPageAnimatableComponent extends StatelessWidget {
  final double opacity;
  final String mainAsset;
  final String heading;
  final String description;

  final double assetTopSpace;
  final double headingTopSpace;

  final bool customDescriptionWidgetEnabled;
  final Widget customDescriptionWidget;

  const LandingPageAnimatableComponent({
    super.key,
    required this.opacity,
    required this.mainAsset,
    required this.heading,
    this.description = "",
    this.assetTopSpace = 40,
    this.headingTopSpace = 80,
    this.customDescriptionWidgetEnabled = false,
    required this.customDescriptionWidget,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Opacity(
      opacity: opacity,
      child: SizedBox(
        width: screenWidth,
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: assetTopSpace)),
            SvgPicture.asset(mainAsset),
            Padding(
              padding: EdgeInsets.only(top: headingTopSpace),
              child: SizedBox(
                width: screenWidth * 0.8,
                child: Text(
                  heading,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            customDescriptionWidgetEnabled
                ? customDescriptionWidget
                : Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: SizedBox(
                      width: screenWidth,
                      child: Text(
                        description,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
