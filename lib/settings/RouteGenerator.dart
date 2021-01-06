import 'package:flutter/material.dart';
import 'package:flutter_water_reminder_app/pages/GoalPage.dart';
import 'package:flutter_water_reminder_app/pages/HomePage.dart';
import 'package:flutter_water_reminder_app/pages/SplashPage.dart';

class RouteGenerator {
  static bool _splashOnce = false;

  static Route<dynamic> generateRoute(RouteSettings setting) {
    final args = setting.arguments;

    switch (setting.name) {
      case "/":
        if (RouteGenerator._splashOnce) {
          int initTab = 0;

          if (args is int) initTab = args;
          return MaterialPageRoute(builder: (_) => HomePage(initTab));
        } else {
          RouteGenerator._splashOnce = true;
          return MaterialPageRoute(builder: (_) => SplashScreen());
        }
        break;
      case "/goal":
        return MaterialPageRoute(builder: (_) => GoalPage());
        break;
    }

    return MaterialPageRoute(builder: (_) => HomePage(0));
  }
}
