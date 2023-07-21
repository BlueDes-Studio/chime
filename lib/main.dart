import 'package:chime/config/colorscheme.dart';
import 'package:chime/screens/landingpages/index.dart';
import 'package:flutter/material.dart';

import 'screens/landingpages/page1.dart';
import 'screens/landingpages/page2.dart';
import 'screens/landingpages/page3.dart';
import 'screens/landingpages/page4.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const Chime());
}

class Chime extends StatelessWidget {
  const Chime({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chime',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: chimePurple),
        useMaterial3: true,
      ),
      navigatorKey: navigatorKey,
      initialRoute: LandingPages.route,
      routes: {
        LandingPage1.route: (context) => const LandingPage1(),
        LandingPage2.route: (context) => const LandingPage2(),
        LandingPage3.route: (context) => const LandingPage3(),
        LandingPage4.route: (context) => const LandingPage4(),
        LandingPages.route: (context) => const LandingPages(),
      },
    );
  }
}
