import 'package:chime/config/colorscheme.dart';
import 'package:chime/screens/auth/auth.dart';
import 'package:chime/screens/calendar.dart';
import 'package:chime/screens/dashboard.dart';
import 'package:flutter/material.dart';

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
      initialRoute: Calendar.route,
      routes: {
        //auth pages
        AuthScreen.route: (context) => const AuthScreen(),

        //app screens
        Dashboard.route: (context) => const Dashboard(),
        Calendar.route: (context) => const Calendar(),
      },
    );
  }
}
