import 'dart:math';

import 'package:chime/utils/dashboard.dart';
import 'package:flutter/material.dart';

import '../../atoms/linear_percent_indicator.dart';

class FutureAttendancePercentageSpecs extends StatelessWidget {
  final double percentage;
  final int index;
  const FutureAttendancePercentageSpecs({
    super.key,
    required this.percentage,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              Text(
                "${percentage.toInt()}%",
                style: const TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: 55,
                width: 50,
                // color: Colors.red,
                child: Stack(
                  children: [
                    Positioned(
                      top: 20,
                      right: -9,
                      child: Transform.rotate(
                        angle: pi * -0.5,
                        // angle: 0,
                        child: LinearPercentIndicator(
                          percent: percentage / 100,
                          backgroundColor: Colors.transparent,
                          progressColor: getProgressBarColor(percentage),
                          barRadius: const Radius.circular(10),
                          width: 70,
                          lineHeight: 10,
                          animation: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "$index",
                style: const TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
