import 'package:groupup/models/user_input_data.dart';

class Participant {
  final String name, profilePicture, rank;

  final List<UserInputData> inputData;

  UserInputData get sumData {
    double sum = 0;
    for (UserInputData data in inputData) {
      sum += data.value;
    }
    return UserInputData(
      value: sum,
      date: DateTime.now(),
    );
  }

  Participant({
    required this.name,
    required this.profilePicture,
    required this.rank,
    required this.inputData,
  });

  factory Participant.fromMap(map) {
    return Participant(
        name: map['name'],
        profilePicture: map['profilePicture'],
        rank: map['rank'],
        inputData: map['groups']);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'profilePicture': profilePicture,
      'rank': rank,
      'inputData': inputData,
    };
  }
}
