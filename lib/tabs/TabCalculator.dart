import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myhelloworld/manager/AppDataManager.dart';

class TabCalculator extends StatefulWidget {
  @override
  _TabCalculatorState createState() => _TabCalculatorState();
}

class _TabCalculatorState extends State<TabCalculator> {
  TextEditingController _txtWeight;

  double _userShouldDrink = 0;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: 10,
        ),
        Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: FittedBox(
              fit: BoxFit.fill,
              child: Text(
                "Daily Water Intake Calculator",
                style: TextStyle(fontSize: 24),
              ),
            )),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Text(
            """Use this hydration calculator to learn how much water you should drink daily based on your weight.""",
            style: TextStyle(fontSize: 16, color: Colors.black87),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: TextField(
            keyboardType: TextInputType.number,
            onChanged: this._onChangedTextWeightField,
            onSubmitted: this._onChangedTextWeightField,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration: InputDecoration(
              labelText: 'Weight (Kg)',
              prefixIcon: Icon(Icons.edit),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            controller: _txtWeight,
          ),
        ),
        if (_userShouldDrink > 0)
          Padding(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("You should drink", style: TextStyle(fontSize: 14)),
                  Text(_userShouldDrink.toStringAsFixed(0) + " ml",
                      style: TextStyle(fontSize: 24)),
                  Text("per day", style: TextStyle(fontSize: 11)),
                  SizedBox(height: 10),
                  FlatButton(
                    onPressed: this._onClickSetNewGoal,
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Icon(Icons.save),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "use this number as my goal",
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
      ],
    );
  }

  void _onClickSetNewGoal() {
    if (this._userShouldDrink != null && this._userShouldDrink > 0) {
      AppDataManager.instance.setUserData(goal: this._userShouldDrink.toInt());
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/', (route) => false, arguments: 0);
    }
  }

  void _onChangedTextWeightField(String txtValue) {
    setState(() {
      if (txtValue == null || txtValue.length == 0) {
        _userShouldDrink = 0;
        return;
      }

      final int numWeight = int.parse(txtValue);
      if (numWeight == null || numWeight <= 0) {
        _userShouldDrink = 0;
        return;
      }

      this._userShouldDrink = (numWeight.toDouble() * 0.033) * 1000;
    });
  }
}
