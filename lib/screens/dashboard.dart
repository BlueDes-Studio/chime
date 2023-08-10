import 'dart:math';

import 'package:chime/config/colorscheme.dart';
import 'package:flutter/material.dart';
import 'package:simple_shadow/simple_shadow.dart';

class SubjectEntryComponent extends StatelessWidget {
  final int index;
  final void Function() removeEntry;

  const SubjectEntryComponent({
    super.key,
    required this.index,
    required this.removeEntry,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "class$index:",
            style: const TextStyle(
              fontFamily: "Poppins",
              fontSize: 14,
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
            onPressed: removeEntry,
            icon: const Icon(
              Icons.delete,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class SubjectInputComponent extends StatelessWidget {
  final String hintText;
  const SubjectInputComponent({super.key, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 13),
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9 * 0.9,
            height: 40,
            child: TextFormField(
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
              decoration: InputDecoration(
                hintText: hintText,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 15,
                ),
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontFamily: "Poppins",
                  fontSize: 16,
                ),
              ),
              style: const TextStyle(
                fontSize: 15.0,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Dashboard extends StatefulWidget {
  static String route = "/app/dashboard";
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class SubjectEntryData {
  String day;
  String time;

  SubjectEntryData({
    required this.day,
    required this.time,
  });
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
            top: 100,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 100 - 70,
              color: const Color(0xffEFF1FF),
              //render all subjects in here
              child: const Center(
                child: Text(
                  "Tap the + button  to add a subject to the dashboard",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 20,
                    color: Color(0xff8E8E8E),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 70,
            child: Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: const Text(
                "Dashboard",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
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
                  const ImageIcon(AssetImage("assets/calendar.png"), size: 35),
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
              icon: const ImageIcon(AssetImage("assets/home.png"), size: 35),
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
