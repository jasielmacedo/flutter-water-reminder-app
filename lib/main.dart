import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_water_reminder_app/manager/DataManager.dart';
import 'package:flutter_water_reminder_app/manager/LocalNotificationManager.dart';
import 'package:flutter_water_reminder_app/settings/RouteGenerator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  LocalNotificationManager.init();

  runApp(FlutterWaterReminderApp());
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
}

class FlutterWaterReminderApp extends StatefulWidget {
  @override
  _FlutterWaterReminderAppState createState() =>
      _FlutterWaterReminderAppState();
}

class _FlutterWaterReminderAppState extends State<FlutterWaterReminderApp> {
  @override
  void initState() {
    DataManager.initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.lightBlue.shade200),
      initialRoute: "/",
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
