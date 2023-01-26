import 'package:flutter/material.dart';
import 'package:groupup/models/user_input_data.dart';
import 'package:provider/provider.dart';

import '../core/providers/individual_group_provider.dart';

class Participant {
  String name, profilePicture, uid;
  bool isAdmin;

  String rank(BuildContext context) {
    final individualGroupProvider = Provider.of<IndividualGroupProvider>(
      context,
      listen: false,
    );
    if (inputData.isEmpty) {
      return '-';
    }
    if (individualGroupProvider.group == null) return '-';
    int rank = 1;
    for (var element in individualGroupProvider.group!.participantsData) {
      if (element.sumData.value > sumData.value) {
        rank++;
      }
    }
    return '${rank.toString()}º';
  }

  List<UserInputData> inputData;

  bool get hasStory {
    return inputData
        .where(
          (inputData) =>
              inputData.date.isAfter(
                DateTime.now().subtract(
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
      'inputData': inputData.map((e) => e.toMap()).toList(),
    };
  }
}
