import 'package:groupup/models/user_input_data.dart';

class Participant {
  final String name, profilePicture, uid;
  final bool isAdmin;

  String get rank {
    return '';
  }

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
    required this.uid,
    required this.name,
    required this.profilePicture,
    required this.inputData,
    required this.isAdmin,
  });

  factory Participant.fromMap(map) {
    return Participant(
      uid: map['uid'],
      name: map['name'],
      profilePicture: map['profilePicture'],
      inputData: ((map['inputData'] ?? []) as List)
          .map(
            (e) => UserInputData.fromMap(e),
          )
          .toList(),
      isAdmin: map['isAdmin'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'profilePicture': profilePicture,
      'isAdmin': isAdmin,
      'inputData': inputData,
    };
  }
}
