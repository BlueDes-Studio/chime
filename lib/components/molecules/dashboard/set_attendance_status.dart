import 'package:chime/utils/dashboard.dart';
import 'package:flutter/material.dart';

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
