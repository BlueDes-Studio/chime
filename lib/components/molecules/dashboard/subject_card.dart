import 'dart:math';

import 'package:chime/components/atoms/circular_progress_indicator.dart';
import 'package:chime/components/atoms/linear_percent_indicator.dart';
import 'package:flutter/material.dart';
import 'package:simple_shadow/simple_shadow.dart';

Color getProgressBarColor(double percentage) {
  if (percentage <= 100 && percentage > 75) {
    return const Color(0xff91EC59);
  }
  if (percentage <= 75 && percentage > 50) {
    return const Color(0xffEFDE47);
  }
  return const Color(0xffEC5959);
}

double recommendNumberOfClassesToAttend(int attended, int total, int target) {
  return ((target * total) - (100 * attended)) / (100 - target);
}

class SetAttendanceStatus extends StatefulWidget {
  const SetAttendanceStatus({super.key});

  @override
  State<SetAttendanceStatus> createState() => _SetAttendanceStatusState();
}

class _SetAttendanceStatusState extends State<SetAttendanceStatus> {
  String parsedDate = "";
  Map<String, bool> attendanceStatus = {
    "present": false,
    "absent": false,
    "cancelled": false,
  };

  @override
  void initState() {
    super.initState();
    DateTime dateTime = DateTime.now();

    switch (dateTime.weekday) {
      case DateTime.sunday:
        parsedDate += "Sun | ";
      case DateTime.monday:
        parsedDate += "Mon | ";
      case DateTime.tuesday:
        parsedDate += "Tue | ";
      case DateTime.wednesday:
        parsedDate += "Wed | ";
      case DateTime.thursday:
        parsedDate += "Thu | ";
      case DateTime.friday:
        parsedDate += "Fri | ";
      case DateTime.saturday:
        parsedDate += "Sat | ";
    }

    parsedDate += "${dateTime.day}th :";
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(
              parsedDate,
              style: const TextStyle(
                fontFamily: "Poppins",
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                attendanceStatus["present"]!
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            attendanceStatus.update(
                                "present", (value) => false);
                          });
                        },
                        child:
                            Image.asset("assets/attendance-present-check.png"))
                    : GestureDetector(
                        onTap: () {
                          setState(() {
                            attendanceStatus
                                .updateAll((key, value) => key == "present");
                          });
                        },
                        child: Image.asset(
                            "assets/attendance-present-check-outlined.png")),
                attendanceStatus["absent"]!
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            attendanceStatus.update("absent", (value) => false);
                          });
                        },
                        child: Image.asset("assets/attendance-absent.png"))
                    : GestureDetector(
                        onTap: () {
                          setState(() {
                            attendanceStatus
                                .updateAll((key, value) => key == "absent");
                          });
                        },
                        child: Image.asset(
                            "assets/attendance-absent-outlined.png"),
                      ),
                attendanceStatus["cancelled"]!
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            attendanceStatus.update(
                                "cancelled", (value) => false);
                          });
                        },
                        child: Image.asset("assets/attendance-cancelled.png"))
                    : GestureDetector(
                        onTap: () {
                          setState(() {
                            attendanceStatus
                                .updateAll((key, value) => key == "cancelled");
                          });
                        },
                        child: Image.asset(
                            "assets/attendance-cancelled-outlined.png")),
                Image.asset("assets/attendance-postponed.png"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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

class SubjectCard extends StatelessWidget {
  final String subjectName;
  final int totalDays;
  final int attendedDays;
  const SubjectCard({
    super.key,
    required this.subjectName,
    required this.totalDays,
    required this.attendedDays,
  });

  @override
  Widget build(BuildContext context) {
    int recommendedClassesToAttend =
        recommendNumberOfClassesToAttend(attendedDays, totalDays, 75).round();
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: SimpleShadow(
        opacity: 0.2, // Default: 0.5
        offset: const Offset(0, 3), // Default: Offset(2, 2)
        sigma: 3,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          // height: 260,
          // constraints: const BoxConstraints(minHeight: 240, maxHeight: 240),
          child: Column(
            children: [
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 100,
                              height: 100,
                              child: CircularPercentIndicator(
                                percent: attendedDays / totalDays,
                                radius: 50,
                                lineWidth: 12,
                                backgroundColor: Colors.transparent,
                                progressColor: getProgressBarColor(
                                    (attendedDays / totalDays) * 100),
                                center: Text(
                                  "${((attendedDays / totalDays) * 100).toInt()}%",
                                  style: const TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      FutureAttendancePercentageSpecs(
                                        percentage:
                                            ((attendedDays) / (totalDays + 1)) *
                                                100,
                                        index: 1,
                                      ),
                                      FutureAttendancePercentageSpecs(
                                        percentage:
                                            ((attendedDays) / (totalDays + 2)) *
                                                100,
                                        index: 2,
                                      ),
                                      FutureAttendancePercentageSpecs(
                                        percentage:
                                            ((attendedDays) / (totalDays + 3)) *
                                                100,
                                        index: 3,
                                      ),
                                      FutureAttendancePercentageSpecs(
                                        percentage:
                                            ((attendedDays) / (totalDays + 4)) *
                                                100,
                                        index: 4,
                                      ),
                                    ],
                                  ),
                                  const Text(
                                    "attendance after number of absents",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 10,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Text(
                          subjectName,
                          style: const TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      recommendedClassesToAttend > 0
                          ? Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: Text(
                                "you need $recommendedClassesToAttend  more classes to hit your goal",
                                style: const TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 12,
                                ),
                              ),
                            )
                          : Container(),
                      Container(
                        height: 10,
                      ),
                      const Divider(),
                      const SetAttendanceStatus(),
                      Container(
                        height: 15,
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
