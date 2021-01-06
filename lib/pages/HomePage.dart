import 'package:flutter/material.dart';
import 'package:flutter_water_reminder_app/tabs/TabCalculator.dart';
import 'package:flutter_water_reminder_app/tabs/TabHome.dart';
import 'package:flutter_water_reminder_app/tabs/TabReminder.dart';

class HomePage extends StatefulWidget {
  final int initialTab;

  HomePage(this.initialTab);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentTab = 0;

  final List<BottomNavigationBarItem> bottomBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.water_damage),
      backgroundColor: Colors.blue.shade300,
      label: "Home",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.watch_later),
      label: "Reminder",
      backgroundColor: Colors.blue.shade300,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.calculate),
      label: "Calculator",
      backgroundColor: Colors.blue.shade300,
    )
  ];

  @override
  void initState() {
    super.initState();
    currentTab = widget.initialTab;
  }

  void _changeTab(int newTab) {
    setState(() {
      if (this.currentTab >= this.bottomBarItems.length) return;
      this.currentTab = newTab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(this._getTabText(), style: TextStyle(fontSize: 14)),
        ),
      ),
      backgroundColor: Colors.white,
      body: this._getTab(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: this.currentTab,
        items: bottomBarItems,
        onTap: this._changeTab,
      ),
    );
  }

  Widget _getTab() {
    switch (this.currentTab) {
      case 1:
        return TabReminder();
        break;
      case 2:
        return TabCalculator();
      default:
        return TabHome();
    }
  }

  String _getTabText() {
    switch (this.currentTab) {
      case 1:
        return "Reminder";
      case 2:
        return "Calculator";
      default:
        return "Let's get hydrated";
    }
  }
}
