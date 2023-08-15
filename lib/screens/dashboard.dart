import 'dart:math';

import 'package:chime/components/molecules/dashboard/subject_card.dart';
import 'package:chime/components/molecules/dashboard/subject_entry.dart';
import 'package:chime/components/molecules/dashboard/subject_input_component.dart';
import 'package:chime/config/colorscheme.dart';
import 'package:flutter/material.dart';
import 'package:simple_shadow/simple_shadow.dart';

class SubjectEntryData {
  String day;
  String time;

  SubjectEntryData({
    required this.day,
    required this.time,
  });
}

class Dashboard extends StatefulWidget {
  static String route = "/app/dashboard";
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );

  bool addButtonState = true;

  late final Animation<double> _rotationAnimation = Tween<double>(
    begin: 0,
    end: pi + pi * 0.25,
  ).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastOutSlowIn,
    ),
  );

  late final Animation<double> _slideTransition = Tween<double>(
    begin: -300,
    end: 110,
  ).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastOutSlowIn,
    ),
  );

  List<SubjectEntryData> subjectsEntries = [
    SubjectEntryData(day: "", time: ""),
  ];

  @override
  void initState() {
    _animationController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEFF1FF),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 70,
              color: const Color(0xffEFF1FF),
              //render all subjects in here
              // child: Center(
              // child: Text(
              //   "Tap the + button  to add a subject to the dashboard",
              //   textAlign: TextAlign.center,
              //   style: TextStyle(
              //     fontFamily: "Roboto",
              //     fontSize: 20,
              //     color: Color(0xff8E8E8E),
              //   ),
              // ),
              child: ListView(
                children: [
                  Container(
                    height: 20,
                  ),
                  const Text(
                    "Dashboard",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SubjectCard(
                    subjectName: "Signals and System",
                    attendedDays: 5,
                    totalDays: 17,
                    takeClassAttendance: true,
                  ),
                  const SubjectCard(
                    subjectName: "Digital Logic and Design",
                    attendedDays: 10,
                    totalDays: 17,
                    takeClassAttendance: false,
                  ),
                  const SubjectCard(
                    subjectName: "Discrete Mathematics",
                    attendedDays: 17,
                    totalDays: 17,
                    takeClassAttendance: false,
                  ),
                  Container(
                    height: 40,
                  )
                ],
              ),
            ),
          ),

          //subject input component
          Positioned(
            bottom: MediaQuery.of(context).viewInsets.bottom > 0
                ? 10
                : _slideTransition.value,
            child: SimpleShadow(
              opacity: 0.2, // Default: 0.5
              offset: const Offset(0, 3), // Default: Offset(2, 2)
              sigma: 3,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 240,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: ListView(
                      padding: const EdgeInsets.all(0),
                      children: [
                        const SubjectInputComponent(hintText: "Subject name"),
                        const SubjectInputComponent(
                          hintText: "Professor's name",
                        ),
                        ...[
                          for (int i = 0; i < subjectsEntries.length; i++)
                            SubjectEntryComponent(
                              index: i + 1,
                              removeEntry: () => setState(() {
                                if (subjectsEntries.length > 1) {
                                  subjectsEntries.removeAt(i);
                                }
                              }),
                            ),
                        ],
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      subjectsEntries.add(
                                        SubjectEntryData(
                                          day: "",
                                          time: "",
                                        ),
                                      );
                                    });
                                  },
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
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: FilledButton(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(chimePurple),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                  child: const Text("Done"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // bottom navigation
          Positioned(
            top: MediaQuery.of(context).size.height - 70,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 70,
              color: Colors.white,
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width / 2 - 30,
            top: MediaQuery.of(context).size.height - 70 - 30,
            child: SimpleShadow(
              color: const Color(0xff873EFF),
              opacity: 0.4, // Default: 0.5
              offset: const Offset(1, 1), // Default: Offset(2, 2)
              sigma: 7,
              child: IconButton(
                icon: Transform.rotate(
                  angle: _rotationAnimation.value,
                  child: const Icon(Icons.add, size: 35),
                ),
                onPressed: () {
                  if (addButtonState) {
                    _animationController.forward();
                    setState(() {
                      addButtonState = false;
                    });
                  } else {
                    _animationController.reverse();
                    setState(() {
                      addButtonState = true;
                    });
                  }
                },
                color: Colors.white,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    const Color(0xff9C60FF),
                  ),
                  fixedSize: const MaterialStatePropertyAll(Size(60, 60)),
                ),
              ),
            ),
          ),
          Positioned(
            left: 40,
            top: MediaQuery.of(context).size.height - 70,
            child: IconButton(
              icon:
                  const ImageIcon(AssetImage("assets/calendar.png"), size: 25),
              onPressed: () {},
              color: Colors.black,
              style: const ButtonStyle(
                fixedSize: MaterialStatePropertyAll(Size(60, 60)),
              ),
            ),
          ),
          Positioned(
            right: 40,
            top: MediaQuery.of(context).size.height - 70,
            child: IconButton(
              icon: const ImageIcon(AssetImage("assets/home.png"), size: 25),
              onPressed: () {},
              color: Colors.black,
              style: const ButtonStyle(
                fixedSize: MaterialStatePropertyAll(Size(60, 60)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
