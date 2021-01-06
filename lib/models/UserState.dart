class UserState {
  int userCurrentProgress;
  DateTime userCurrentProgressLastDate;
  int userCurrentGoal;
  bool enableNotifications = true;

  UserState(
      {this.userCurrentGoal = 2000,
      this.userCurrentProgress = 0,
      this.userCurrentProgressLastDate,
      this.enableNotifications = true});

  UserState.fromJson(Map<String, dynamic> json)
      : userCurrentGoal = json['userCurrentGoal'],
        userCurrentProgressLastDate =
            DateTime.parse(json['userCurrentProgressLastDate']),
        userCurrentProgress = json['userCurrentProgress'],
        enableNotifications = json['enableNotifications'];

  Map<String, dynamic> toJson() => {
        'userCurrentGoal': userCurrentGoal,
        'userCurrentProgressLastDate':
            userCurrentProgressLastDate.toIso8601String(),
        'userCurrentProgress': userCurrentProgress,
        'enableNotifications': enableNotifications
      };
}
