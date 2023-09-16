import 'package:chime/utils/calendar.dart';
import 'package:flutter/material.dart';
import 'package:simple_shadow/simple_shadow.dart';

class Calendar extends StatefulWidget {
  static String route = "/app/calendar";
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _datesLoaderAnimationController =
      AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );

  late final Animation<double> datesSelectorDivShiftAnimation = Tween<double>(
    begin: 0,
    end: 100,
  ).animate(
    CurvedAnimation(
      parent: _datesLoaderAnimationController,
      curve: Curves.fastOutSlowIn,
    ),
  );

  @override
  void initState() {
    _datesLoaderAnimationController.addListener(() {
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
          //datesSelector
          Positioned(
            top: 50,
            child: Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: Container(
                width: 200,
                height: 40,
                decoration: const BoxDecoration(
                  color: Color(0xff474747),
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: datesSelectorDivShiftAnimation.value,
                      child: Container(
                        width: 100,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Color(0xff9C60FF),
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      child: GestureDetector(
                        onTap: () {
                          if (datesSelectorDivShiftAnimation.value == 100) {
                            _datesLoaderAnimationController.reverse();
                          }
                        },
                        child: const SizedBox(
                          width: 100,
                          height: 40,
                          child: Center(
                            child: Text(
                              "Week",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          if (datesSelectorDivShiftAnimation.value == 0) {
                            _datesLoaderAnimationController.forward();
                          }
                        },
                        child: const SizedBox(
                          width: 100,
                          height: 40,
                          child: Center(
                            child: Text(
                              "Month",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          //month dates
          Positioned(
            top: 120,
            child: Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                height: 350,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Padding(
                            padding: EdgeInsets.only(left: 7),
                            child: Icon(Icons.arrow_back_ios),
                          ),
                        ),
                        Text(
                          getCurrMonth_MonthYYYY(),
                          style: const TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 16,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2),
                            child: Icon(Icons.arrow_forward_ios),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: GridView.count(
                        padding: EdgeInsets.zero,
                        crossAxisCount: 7,
                        children: [
                          for (String day in [
                            "Sun",
                            "Mon",
                            "Tue",
                            "Wed",
                            "Thu",
                            "Fri",
                            "Sat"
                          ])
                            SizedBox(
                              width: 40,
                              child: Center(
                                child: Text(
                                  day,
                                  style: const TextStyle(
                                    fontFamily: "Poppins",
                                    color: Color(0xff474747),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          for (DateValueReturned date
                              in genDateArray_forMonth(DateTime.now().month))
                            SizedBox(
                              width: 40,
                              child: Center(
                                child: Text(
                                  date.val,
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    color: date.currMonth
                                        ? const Color(0xff474747)
                                        : Colors.grey,
                                  ),
                                ),
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

          //week dates
          // Positioned(
          //   top: 120,
          //   child: SizedBox(
          //     width: MediaQuery.of(context).size.width,
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //       children: [
          //         Container(
          //           width: 3,
          //         ),
          //         for (int i = 0; i < 7; i++)
          //           SimpleShadow(
          //             opacity: 0.2, // Default: 0.5
          //             offset: const Offset(0, 3), // Default: Offset(2, 2)
          //             sigma: 3,
          //             child: Container(
          //               width: 45,
          //               height: 80,
          //               decoration: const BoxDecoration(
          //                 color: Colors.white,
          //                 borderRadius: BorderRadius.all(
          //                   Radius.circular(30),
          //                 ),
          //               ),
          //               child: Column(
          //                 mainAxisAlignment: MainAxisAlignment.center,
          //                 children: [
          //                   Text(
          //                     "$i",
          //                     style: const TextStyle(
          //                       fontFamily: "Poppins",
          //                       fontWeight: FontWeight.w600,
          //                       fontSize: 20,
          //                     ),
          //                   ),
          //                   Text(
          //                     convertIntToWeekDay(i),
          //                     style: const TextStyle(
          //                       fontFamily: "Poppins",
          //                       fontSize: 14,
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ),
          //         Container(
          //           width: 3,
          //         ),
          //       ],
          //     ),
          //   ),
          // ),

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
