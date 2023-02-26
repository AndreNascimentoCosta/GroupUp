import 'package:groupup/models/group_model.dart';
import 'package:groupup/models/user_input_data.dart';

class Participant {
  String name, profilePicture, uid;
  bool isAdmin;

  String rank(GroupModel? group) {
    if (inputData.isEmpty) {
      return '-';
    }
    if (group == null) {
      return '-';
    }
    int rank = 1;
    for (var element in group.participantsData) {
      if (element.sumData.value > sumData.value) {
        rank++;
      }
    }
    return '$rankº';
  }

  List<UserInputData> inputData;

  bool get hasStory {
    return inputData
        .where(
          (inputData) =>
              inputData.date.toUtc().isAfter(
                    DateTime.now().toUtc().subtract(
                          const Duration(days: 1),
                        ),
                  ) &&
              inputData.image != null,
        )
        .isNotEmpty;
  }

  UserInputData get sumData {
    double sum = 0;
    for (UserInputData data in inputData) {
      sum += data.value;
    }
    return UserInputData(
      value: sum,
      date: DateTime.now().toUtc(),
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

  factory Participant.empty() {
    return Participant(
      uid: '',
      name: '',
      profilePicture: '',
      inputData: [],
      isAdmin: false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'profilePicture': profilePicture,
      'isAdmin': isAdmin,
      'inputData': inputData.map((e) => e.toMap()).toList(),
    };
  }
}
