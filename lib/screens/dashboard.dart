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

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );

  late final AnimationController _postponedAnimationController =
      AnimationController(
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

  late final Animation<double> _slidePostponedTransition = Tween<double>(
    begin: -300,
    end: 110,
  ).animate(
    CurvedAnimation(
      parent: _postponedAnimationController,
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
    _postponedAnimationController.addListener(() {
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
          // Container(
          //   height: 20,
          // ),
          Positioned(
            top: 100,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 70 - 100,
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
                scrollDirection: Axis.vertical,
                children: [
                  SubjectCard(
                    subjectName: "Signals and System",
                    attendedDays: 5,
                    totalDays: 17,
                    cancelDays: 0,
                    takeClassAttendance: true,
                    postponedAnimationController: _postponedAnimationController,
                  ),
                  SubjectCard(
                    subjectName: "Digital Logic and Design",
                    attendedDays: 10,
                    totalDays: 17,
                    cancelDays: 0,
                    takeClassAttendance: false,
                    postponedAnimationController: _postponedAnimationController,
                  ),
                  SubjectCard(
                    subjectName: "Discrete Mathematics",
                    attendedDays: 17,
                    totalDays: 17,
                    cancelDays: 0,
                    takeClassAttendance: false,
                    postponedAnimationController: _postponedAnimationController,
                  ),
                  Container(
                    height: 40,
                  )
                ],
              ),
            ),
          ),

          if (_slidePostponedTransition.value > -300 ||
              _slideTransition.value > -300)
            Positioned(
              child: Container(
                color: Colors.black.withOpacity(0.2),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
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

          //postponed component
          Positioned(
            bottom: _slidePostponedTransition.value,
            child: TapRegion(
              onTapOutside: (event) {
                _postponedAnimationController.reverse();
              },
              child: SimpleShadow(
                opacity: 0.2, // Default: 0.5
                offset: const Offset(0, 3), // Default: Offset(2, 2)
                sigma: 3,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: 145,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding:
                                EdgeInsets.only(top: 10, left: 20, bottom: 5),
                            child: Text(
                              "Postponed to:",
                              style: TextStyle(
                                color: lightGrey,
                                fontFamily: "Poppins",
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 100,
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
                                  width: 100,
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
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, left: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: FilledButton(
                                    onPressed: () {
                                      _postponedAnimationController.reverse();
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              chimePurple),
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
          ),

          //page header
          Positioned(
            top: 0,
            child: SimpleShadow(
              opacity: 0.2, // Default: 0.5
              offset: const Offset(0, 3), // Default: Offset(2, 2)
              sigma: 3,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                alignment: Alignment.bottomCenter,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: Text(
                    "Dashboard",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // bottom navigation
          Positioned(
            top: MediaQuery.of(context).size.height - 70,
            child: SimpleShadow(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 70,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
              ),
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
                    chimePurple,
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
