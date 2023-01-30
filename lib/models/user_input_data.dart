class UserInputData {
  final DateTime date;
  double value;
  final String? image;
  Map<String, dynamic>? isValidated;

  UserInputData({
    required this.date,
    required this.value,
    this.image,
    this.isValidated,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'value': value,
      'image': image,
      'isValidated': isValidated,
    };
  }

  factory UserInputData.fromMap(map) {
    return UserInputData(
      date: map['date'].toDate(),
      value: map['value'],
      image: map['image'],
      isValidated: map['isValidated'],
    );
  }
}
