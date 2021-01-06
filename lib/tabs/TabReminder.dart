import 'package:flutter/material.dart';
import 'package:flutter_water_reminder_app/manager/LocalNotificationManager.dart';

class TabReminder extends StatefulWidget {
  @override
  _TabReminderState createState() => _TabReminderState();
}

class _TabReminderState extends State<TabReminder> {
  bool _enableNotifications = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: <Widget>[
                  Icon(
                    Icons.lock_clock,
                    size: 24,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "Receive notifications",
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
              Switch(
                onChanged: _onChangedSwitchNotifications,
                value: _enableNotifications,
                activeColor: Colors.blue,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: <Widget>[
                  Icon(
                    Icons.watch_later_sharp,
                    size: 24,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "Interval",
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(""),
            ),
          )
        ],
      ),
    );
  }

  void _onChangedSwitchNotifications(bool newValue) {
    setState(() {
      _enableNotifications = newValue;

      if (_enableNotifications) {
        LocalNotificationManager.instance.instantShowNotification();
        _scheduleNotifications();
      }
    });
  }

  void _scheduleNotifications() {
    LocalNotificationManager.instance.repeatNotification();
  }
}
