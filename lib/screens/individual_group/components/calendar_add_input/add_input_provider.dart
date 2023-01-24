import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:groupup/models/group_model.dart';
import 'package:groupup/models/user_input_data.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:ntp/ntp.dart';
import 'package:provider/provider.dart';

import '../../../../core/providers/individual_group_provider.dart';

class AddInputProvider extends ChangeNotifier {
  final TextEditingController inputController = TextEditingController();

  AddInputProvider() {
    inputController.addListener(notifyListeners);
  }

  Future<void> addInput(BuildContext context, String groupId) async {
    final user = Provider.of<AuthProvider>(context, listen: false).user;
    final individualGroupProvider =
        Provider.of<IndividualGroupProvider>(context, listen: false);
    if (user == null) {
      return;
    }
    final value = double.parse(inputController.text);
    final group = await FirebaseFirestore.instance
        .collection('groups')
        .doc(groupId)
        .get();
    if (group.exists) {
      final groupData = group.data();
      if (groupData != null) {
        final participantsData =
            GroupModel.fromMap(group.id, groupData).participantsData;
        final userIndex =
            participantsData.indexWhere((element) => element.uid == user.id);
        if (userIndex != -1) {
          final userParticipantData = participantsData[userIndex];
          final inputDataIndex = userParticipantData.inputData.indexWhere(
            (element) =>
                element.date.day == DateTime.now().day &&
                element.date.month == DateTime.now().month &&
                element.date.year == DateTime.now().year,
          );
          final offset = await NTP.getNtpOffset(
              localTime: DateTime.now(), lookUpAddress: "time.google.com");
          final internetTime =
              DateTime.now().add(Duration(milliseconds: offset));
          final newInput = UserInputData(
            date: internetTime,
            value: value,
          );
          if (inputDataIndex != -1) {
            userParticipantData.inputData.removeAt(inputDataIndex);
          }
          userParticipantData.inputData.add(newInput);
          participantsData[userIndex] = userParticipantData;
          await FirebaseFirestore.instance
              .collection('groups')
              .doc(groupId)
              .update(
            {
              'participantsData':
                  participantsData.map((e) => e.toMap()).toList(),
            },
          );
          individualGroupProvider.getGroup(groupId, reset: false);
        }
      }
    }
  }
}
