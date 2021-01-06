import 'dart:async';
import 'dart:convert';

import 'package:flutter_water_reminder_app/models/CupModel.dart';
import 'package:flutter_water_reminder_app/models/UserState.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataManager {
  static const String _dataSavedKey = "_userPreferences";

  static DataManager instance;

  static void initialize() {
    DataManager.instance = DataManager();
  }

  UserState userData;

  int get userCurrentProgress => userData.userCurrentProgress;

  DateTime get userCurrentProgressLastDate =>
      userData.userCurrentProgressLastDate;

  int get userCurrentGoal => userData.userCurrentGoal;

  bool get enableNotifications => userData.enableNotifications;

  List<CupModel> cupsAvailable = [
    CupModel(100),
    CupModel(150),
    CupModel(200),
    CupModel(300),
    CupModel(400),
    CupModel(500),
    CupModel(750),
    CupModel(800),
    CupModel(900),
    CupModel(920),
    CupModel(1000),
  ];

  DataManager() {
    userData = UserState();
    _readUserPreferences();

    final today = DateTime.now();

    if (this.userCurrentProgressLastDate == null ||
        this.userCurrentProgressLastDate.day != today.day ||
        this.userCurrentProgressLastDate.month != today.month ||
        this.userCurrentProgressLastDate.year != today.year) {
      this.setUserData(progress: 0);
    }
  }

  void _readUserPreferences() async {
    try {
      this.userData = await this._loadData();
      if (this.userData == null)
        this.userData = UserState(userCurrentProgressLastDate: DateTime.now());
    } catch (e) {
      print(e);
      this.userData = UserState();
    }
  }

  Future<bool> setUserData(
      {final int goal, final int progress, final bool bNotifications}) async {
    Completer<bool> _completer = Completer<bool>();

    if (goal != null && goal > 0) this.userData.userCurrentGoal = goal;
    if (progress != null && progress >= 0) {
      this.userData.userCurrentProgress = progress;
      this.userData.userCurrentProgressLastDate = DateTime.now();
    }

    if (bNotifications != null)
      this.userData.enableNotifications = bNotifications;

    try {
      await this._saveData(userData);
      _completer.complete(true);
    } catch (e) {
      _completer.completeError(e);
    }

    return _completer.future;
  }

  Future<void> _saveData(final UserState finalData) async {
    Completer<void> _completer = Completer<void>();

    if (finalData == null) {
      _completer.completeError("Data cannot be null");
      return _completer.future;
    }

    try {
      final SharedPreferences _prefs = await SharedPreferences.getInstance();

      _prefs.setString(_dataSavedKey, jsonEncode(finalData.toJson()));
      _completer.complete();
    } catch (e) {
      _completer.completeError(e);
    }

    return _completer.future;
  }

  Future<UserState> _loadData() async {
    Completer<UserState> _completer = Completer<UserState>();

    try {
      final SharedPreferences _prefs = await SharedPreferences.getInstance();

      final _dataString = _prefs.getString(_dataSavedKey);
      final _data = UserState.fromJson(jsonDecode(_dataString));

      _completer.complete(_data);
    } catch (e) {
      _completer.completeError(e);
    }

    return _completer.future;
  }
}
