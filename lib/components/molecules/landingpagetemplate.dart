import 'package:flutter/material.dart';

class LandingPageTemplate extends StatelessWidget {
  final List<Widget> children;
  const LandingPageTemplate({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE3EBFF),
      body: Stack(
        children: [
          //linear gradient on top view
          Positioned(
            top: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 160,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xff863DFF),
                    Color(0xffD3C5FF),
                  ],
                ),
              ),
            ),
          ),
          ...children,
        ],
      ),
    );
  }
}
