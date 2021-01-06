import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_water_reminder_app/manager/DataManager.dart';
import 'package:flutter_water_reminder_app/models/CupModel.dart';

class TabHome extends StatefulWidget {
  @override
  _TabHomeState createState() => _TabHomeState();
}

class _TabHomeState extends State<TabHome> {
  int _currentDrank = 0;
  int _goalDrink = 0;
  double _progressBarPercent = 0;

  List<CupModel> cupOptions = [];

  @override
  void initState() {
    super.initState();

    this._currentDrank = DataManager.instance.userCurrentProgress;
    this._goalDrink = DataManager.instance.userCurrentGoal;
    this._progressBarPercent = _calculateProgressBar();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/waterlogo.svg',
                      width: 40,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "$_currentDrank ml",
                      style: TextStyle(fontSize: 40),
                    ),
                    if (_progressBarPercent >= 1.0)
                      Icon(
                        Icons.check,
                        color: Colors.green,
                      )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              LinearProgressIndicator(
                value: _progressBarPercent,
                backgroundColor: Colors.lightBlue.shade100,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "$_currentDrank ml / $_goalDrink ml",
                style: TextStyle(
                  fontSize: 14,
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
        Container(
          height: 40,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                right: 10,
                child: FlatButton(
                  onPressed: _onClickEditGoalButton,
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Icon(
                        Icons.edit,
                        size: 14,
                      ),
                      Text(
                        "Edit goal",
                        style: TextStyle(
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Tap one of these options below according with your last drink",
              style: TextStyle(fontSize: 12),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: GridView.builder(
                itemCount: DataManager.instance.cupsAvailable.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: buildGridItem),
          ),
        )
      ],
    );
  }

  void _onClickEditGoalButton() {
    Navigator.of(this.context).pushNamed("/goal");
  }

  double _calculateProgressBar() {
    final p = this._currentDrank.toDouble() / this._goalDrink.toDouble();
    return p > 1.0 ? 1.0 : p;
  }

  Widget buildGridItem(BuildContext context, int index) {
    return Container(
      child: Card(
          elevation: 10.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: FlatButton(
            onPressed: () {
              this._onClickAddDrinkOption(index);
            },
            child: Align(
              alignment: Alignment.center,
              child: Wrap(
                direction: Axis.vertical,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  (DataManager.instance.cupsAvailable[index].mililiters >= 500
                      ? SvgPicture.asset(
                          'assets/images/sport.svg',
                          width: 32,
                        )
                      : SvgPicture.asset(
                          'assets/images/water.svg',
                          width: 32,
                        )),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    DataManager.instance.cupsAvailable[index].mililiters
                            .toString() +
                        "ml",
                  )
                ],
              ),
            ),
          )),
    );
  }

  void _onClickAddDrinkOption(int index) {
    DataManager.instance
        .setUserData(
            progress: DataManager.instance.userCurrentProgress +
                DataManager.instance.cupsAvailable[index].mililiters)
        .then((value) {
      setState(() {
        this._currentDrank = DataManager.instance.userCurrentProgress;
        this._progressBarPercent = _calculateProgressBar();
      });
    });
  }
}
