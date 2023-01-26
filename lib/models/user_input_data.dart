class UserInputData {
  final DateTime date;
  final double value;
  final String? image;

  UserInputData({
    required this.date,
    required this.value,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'value': value,
      'image': image,
    };
  }

  factory UserInputData.fromMap(map) {
    return UserInputData(
      date: map['date'].toDate(),
      value: map['value'],
      image: map['image'],
    );
  }
}
