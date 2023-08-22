import 'dart:math';

import 'package:chime/components/atoms/circular_progress_indicator.dart';
import 'package:chime/components/atoms/linear_percent_indicator.dart';
import 'package:chime/config/colorscheme.dart';
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
  final void Function(AttendanceStatus status) setAttendanceStatusAction;
  final DateTime? datetime;
  const SetAttendanceStatus({
    super.key,
    required this.setAttendanceStatusAction,
    this.datetime,
  });

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
    DateTime dateTime = widget.datetime ?? DateTime.now();

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
                    ? InkWell(
                        onTap: () {
                          setState(() {
                            attendanceStatus.update(
                                "present", (value) => false);
                          });
                          widget.setAttendanceStatusAction(
                              AttendanceStatus.unselectPresent);
                        },
                        child:
                            Image.asset("assets/attendance-present-check.png"))
                    : InkWell(
                        onTap: () {
                          setState(() {
                            attendanceStatus
                                .updateAll((key, value) => key == "present");
                          });
                          widget.setAttendanceStatusAction(
                              AttendanceStatus.selectPresent);
                        },
                        child: Image.asset(
                            "assets/attendance-present-check-outlined.png")),
                attendanceStatus["absent"]!
                    ? InkWell(
                        onTap: () {
                          setState(() {
                            attendanceStatus.update("absent", (value) => false);
                          });
                          widget.setAttendanceStatusAction(
                              AttendanceStatus.unselectAbsent);
                        },
                        child: Image.asset("assets/attendance-absent.png"))
                    : InkWell(
                        onTap: () {
                          setState(() {
                            attendanceStatus
                                .updateAll((key, value) => key == "absent");
                          });
                          widget.setAttendanceStatusAction(
                              AttendanceStatus.selectAbsent);
                        },
                        child: Image.asset(
                            "assets/attendance-absent-outlined.png"),
                      ),
                attendanceStatus["cancelled"]!
                    ? InkWell(
                        onTap: () {
                          setState(() {
                            attendanceStatus.update(
                                "cancelled", (value) => false);
                          });
                          widget.setAttendanceStatusAction(
                              AttendanceStatus.unselectCancel);
                        },
                        child: Image.asset("assets/attendance-cancelled.png"))
                    : InkWell(
                        onTap: () {
                          setState(() {
                            attendanceStatus
                                .updateAll((key, value) => key == "cancelled");
                          });
                          widget.setAttendanceStatusAction(
                              AttendanceStatus.selectCancel);
                        },
                        child: Image.asset(
                            "assets/attendance-cancelled-outlined.png")),
                InkWell(
                  onTap: () {
                    widget
                        .setAttendanceStatusAction(AttendanceStatus.expandCard);
                  },
                  child: Image.asset("assets/attendance-postponed.png"),
                ),
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

enum AttendanceStatus {
  selectPresent,
  unselectPresent,
  selectAbsent,
  unselectAbsent,
  selectCancel,
  unselectCancel,
  expandCard,
}

class SubjectCard extends StatefulWidget {
  final String subjectName;
  final int totalDays;
  final int attendedDays;
  final int cancelDays;
  final bool takeClassAttendance;

  const SubjectCard({
    super.key,
    required this.subjectName,
    required this.totalDays,
    required this.attendedDays,
    required this.cancelDays,
    required this.takeClassAttendance,
  });

  @override
  State<SubjectCard> createState() => _SubjectCardState();
}

class _SubjectCardState extends State<SubjectCard>
    with SingleTickerProviderStateMixin {
  late int totalDaysCopy;
  late int attendedDaysCopy;
  late int cancelDaysCopy;
  bool showCard = false;

  @override
  void initState() {
    super.initState();
    totalDaysCopy = widget.totalDays;
    attendedDaysCopy = widget.attendedDays;
    cancelDaysCopy = widget.cancelDays;
  }

  void setAttendanceStatusAction(AttendanceStatus status) {
    switch (status) {
      case AttendanceStatus.selectPresent:
        setState(() {
          totalDaysCopy = widget.totalDays + 1;
          attendedDaysCopy = widget.attendedDays + 1;
          cancelDaysCopy = widget.cancelDays;
        });
        break;

      case AttendanceStatus.selectAbsent:
        setState(() {
          totalDaysCopy = widget.totalDays + 1;
          attendedDaysCopy = widget.attendedDays;
          cancelDaysCopy = widget.cancelDays;
        });
        break;

      case AttendanceStatus.unselectPresent:
      case AttendanceStatus.unselectAbsent:
        setState(() {
          totalDaysCopy = widget.totalDays;
          attendedDaysCopy = widget.attendedDays;
          cancelDaysCopy = widget.cancelDays;
        });
        break;

      case AttendanceStatus.selectCancel:
        setState(() {
          totalDaysCopy = widget.totalDays;
          attendedDaysCopy = widget.attendedDays;
          cancelDaysCopy++;
        });
        break;

      case AttendanceStatus.unselectCancel:
        setState(() {
          totalDaysCopy = widget.totalDays;
          attendedDaysCopy = widget.attendedDays;
          cancelDaysCopy--;
        });
        break;

      case AttendanceStatus.expandCard:
        setState(() {
          showCard = true;
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    int recommendedClassesToAttend =
        recommendNumberOfClassesToAttend(attendedDaysCopy, totalDaysCopy, 75)
            .round();

    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: SimpleShadow(
        opacity: 0.2, // Default: 0.5
        offset: const Offset(0, 3), // Default: Offset(2, 2)
        sigma: 3,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          // height: 240,
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
                      GestureDetector(
                        onTap: () {},
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  //circular progress percent
                                  SizedBox(
                                    width: 100,
                                    height: 100,
                                    child: CircularPercentIndicator(
                                      percent: attendedDaysCopy / totalDaysCopy,
                                      radius: 50,
                                      lineWidth: 12,
                                      backgroundColor: Colors.transparent,
                                      progressColor: getProgressBarColor(
                                          (attendedDaysCopy / totalDaysCopy) *
                                              100),
                                      center: Text(
                                        "${((attendedDaysCopy / totalDaysCopy) * 100).toInt()}%",
                                        style: const TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                  //future percent
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            FutureAttendancePercentageSpecs(
                                              percentage: ((attendedDaysCopy) /
                                                      (totalDaysCopy + 1)) *
                                                  100,
                                              index: 1,
                                            ),
                                            FutureAttendancePercentageSpecs(
                                              percentage: ((attendedDaysCopy) /
                                                      (totalDaysCopy + 2)) *
                                                  100,
                                              index: 2,
                                            ),
                                            FutureAttendancePercentageSpecs(
                                              percentage: ((attendedDaysCopy) /
                                                      (totalDaysCopy + 3)) *
                                                  100,
                                              index: 3,
                                            ),
                                            FutureAttendancePercentageSpecs(
                                              percentage: ((attendedDaysCopy) /
                                                      (totalDaysCopy + 4)) *
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
                                widget.subjectName,
                                style: const TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            if (recommendedClassesToAttend > 0)
                              Padding(
                                padding: const EdgeInsets.only(left: 30),
                                child: Text(
                                  "you need $recommendedClassesToAttend  more classes to hit your goal",
                                  style: const TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            Container(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      widget.takeClassAttendance
                          ? Column(
                              children: [
                                const Divider(),
                                SetAttendanceStatus(
                                  setAttendanceStatusAction:
                                      setAttendanceStatusAction,
                                ),
                              ],
                            )
                          : Container(
                              alignment: Alignment.centerRight,
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 23),
                                child: InkWell(
                                  onTap: () {
                                    setAttendanceStatusAction(
                                        AttendanceStatus.expandCard);
                                  },
                                  child: SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: Image.asset(
                                        "assets/attendance-postponed.png"),
                                  ),
                                ),
                              ),
                            ),
                      Container(
                        height: 15,
                      ),
                      AnimatedSize(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.fastOutSlowIn,
                        child: Container(
                          constraints: BoxConstraints(
                              maxHeight: showCard ? double.infinity : 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: Image.asset(
                                      "assets/stats-pie.png",
                                      width: 22,
                                      height: 22,
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: Text(
                                      "Stats",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: Text(
                                      "Total classes : $totalDaysCopy",
                                      style: const TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 30, right: 30, top: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Present : $attendedDaysCopy",
                                      style: const TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      "Absent : ${totalDaysCopy - attendedDaysCopy}",
                                      style: const TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      "Cancel : $cancelDaysCopy",
                                      style: const TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.only(
                              //     left: 30,
                              //     right: 30,
                              //     top: 10,
                              //   ),
                              //   child: Stack(
                              //     children: [
                              //       LinearPercentIndicator(
                              //         percent: 100 / 100,
                              //         backgroundColor: Colors.transparent,
                              //         progressColor: const Color(0xffEFDE47),
                              //         barRadius: const Radius.circular(10),
                              //         width: 327,
                              //         lineHeight: 10,
                              //         animation: true,
                              //       ),
                              //       LinearPercentIndicator(
                              //         percent: 100 / 100,
                              //         backgroundColor: Colors.transparent,
                              //         progressColor: const Color(0xffEC5959),
                              //         barRadius: const Radius.circular(10),
                              //         width: 327 *
                              //             (totalDaysCopy /
                              //                 (totalDaysCopy + cancelDaysCopy)),
                              //         lineHeight: 10,
                              //         animation: true,
                              //       ),
                              //       LinearPercentIndicator(
                              //         percent: 100 / 100,
                              //         backgroundColor: Colors.transparent,
                              //         progressColor: const Color(0xff91EC59),
                              //         barRadius: const Radius.circular(10),
                              //         width: 327 *
                              //             (attendedDaysCopy /
                              //                 (totalDaysCopy + cancelDaysCopy)),
                              //         lineHeight: 10,
                              //         animation: true,
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 30),
                                      child: Image.asset(
                                        "assets/prev-miss-icon.png",
                                        width: 22,
                                        height: 22,
                                      ),
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(top: 10, left: 5),
                                      child: Text(
                                        "Previously missed entries",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: SetAttendanceStatus(
                                  datetime: DateTime(2023, DateTime.august, 15),
                                  setAttendanceStatusAction: (status) {},
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: SetAttendanceStatus(
                                  datetime: DateTime(2023, DateTime.august, 10),
                                  setAttendanceStatusAction: (status) {},
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 30),
                                      child: Image.asset(
                                        "assets/schedule-class.png",
                                        width: 22,
                                        height: 22,
                                      ),
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(top: 10, left: 5),
                                      child: Text(
                                        "Class schedule",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 10,
                                  left: 10,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Text(
                                      "class 1",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 14,
                                      ),
                                    ),
                                    Container(
                                      width: 80,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 1.1,
                                          color: Colors.grey,
                                        ),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          const Icon(
                                            Icons.calendar_month,
                                            color: Colors.grey,
                                            size: 16,
                                          ),
                                          const Text(
                                            "Day",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontFamily: "Poppins",
                                              fontSize: 14,
                                            ),
                                          ),
                                          Container(
                                            width: 5,
                                          ),
                                          const Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Colors.grey,
                                            size: 16,
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 80,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 1.1,
                                          color: Colors.grey,
                                        ),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          const Icon(
                                            Icons.timer,
                                            color: Colors.grey,
                                            size: 16,
                                          ),
                                          const Text(
                                            "Time",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontFamily: "Poppins",
                                              fontSize: 14,
                                            ),
                                          ),
                                          Container(
                                            width: 5,
                                          ),
                                          const Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Colors.grey,
                                            size: 16,
                                          )
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    "add more classes +",
                                    style: TextStyle(
                                      color: chimePurple,
                                      fontFamily: "Poppins",
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                              TapRegion(
                                onTapInside: (event) {
                                  setState(() {
                                    showCard = false;
                                  });
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  height: 50,
                                  decoration: const BoxDecoration(
                                    color: chimePurple,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    ),
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.keyboard_arrow_up,
                                      color: Colors.white,
                                      size: 40,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
