import 'package:flutter/material.dart';
import 'package:simple_shadow/simple_shadow.dart';

List<Widget> bottomNavigation(BuildContext context) {
  return [
    Positioned(
      bottom: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
        color: Colors.white,
      ),
    ),
    Positioned(
      left: MediaQuery.of(context).size.width / 2 - 35,
      bottom: 65,
      child: SimpleShadow(
        color: const Color(0xff873EFF),
        opacity: 0.4, // Default: 0.5
        offset: const Offset(1, 1), // Default: Offset(2, 2)
        sigma: 7,
        child: IconButton(
          icon: const Icon(Icons.add, size: 35),
          onPressed: () {},
          color: Colors.white,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              const Color(0xff9C60FF),
            ),
            fixedSize: const MaterialStatePropertyAll(Size(70, 70)),
          ),
        ),
      ),
    ),
    Positioned(
      left: 40,
      bottom: 36,
      child: IconButton(
        icon: const ImageIcon(AssetImage("assets/calendar.png"), size: 35),
        onPressed: () {},
        color: Colors.black,
        style: const ButtonStyle(
          fixedSize: MaterialStatePropertyAll(Size(60, 60)),
        ),
      ),
    ),
    Positioned(
      right: 40,
      bottom: 36,
      child: IconButton(
        icon: const ImageIcon(AssetImage("assets/home.png"), size: 35),
        onPressed: () {},
        color: Colors.black,
        style: const ButtonStyle(
          fixedSize: MaterialStatePropertyAll(Size(60, 60)),
        ),
      ),
    ),
  ];
}

class Dashboard extends StatelessWidget {
  static String route = "/app/dashboard";
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: const Color(0xffEFF1FF),
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
          ...bottomNavigation(context),
        ],
      ),
    );
  }
}
