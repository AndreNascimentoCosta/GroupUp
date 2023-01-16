class UserInputData {
  final DateTime date;
  final double value;

  UserInputData({
    required this.date,
    required this.value,
  });

  factory UserInputData.fromMap(map) {
    return UserInputData(
      date: map['date'].toDate(),
      value: map['value'],
    );
  }
}
