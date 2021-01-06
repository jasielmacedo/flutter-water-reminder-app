import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_water_reminder_app/manager/DataManager.dart';

class GoalPage extends StatefulWidget {
  @override
  _GoalPageState createState() => _GoalPageState();
}

class _GoalPageState extends State<GoalPage> {
  TextEditingController txtGoal = TextEditingController();

  @override
  void initState() {
    super.initState();
    txtGoal.value =
        TextEditingValue(text: DataManager.instance.userCurrentGoal.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Goal"),
        ),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Set your goal (ml)",
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: InputDecoration(
                  labelText: 'Goal',
                  prefixIcon: Icon(Icons.edit),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                controller: txtGoal,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Align(
                alignment: Alignment.centerRight,
                child: RaisedButton(
                  onPressed: _onClickSaveGoal,
                  child: Text(
                    "Save",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onClickSaveGoal() {
    final String val = txtGoal.text;
    if (val == "" || val == null) return;

    final int iParseGoal = int.parse(val);
    if (iParseGoal == null || iParseGoal <= 0) return;

    DataManager.instance.setUserData(goal: iParseGoal);

    Navigator.of(context).pushNamedAndRemoveUntil("/", (route) => false);
  }
}
