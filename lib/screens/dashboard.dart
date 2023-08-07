import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Dashboard extends StatelessWidget {
  static String route = "/app/dashboard";
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xffEFF1FF),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: Container(
                height: 80,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: SvgPicture.asset("assets/home.svg"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
