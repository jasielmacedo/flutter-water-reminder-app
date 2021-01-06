import 'package:flutter/material.dart';

void main() {
  runApp(FlutterWaterReminderApp());
}

class FlutterWaterReminderApp extends StatefulWidget {
  @override
  _FlutterWaterReminderAppState createState() =>
      _FlutterWaterReminderAppState();
}

class _FlutterWaterReminderAppState extends State<FlutterWaterReminderApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.lightBlue.shade200),
    );
  }
}
