import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/providers/storage_provider.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/widgets/texts/large_body.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/group_model.dart';
import 'package:groupup/models/user_input_data.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/screens/home/components/next_button.dart';
import 'package:ntp/ntp.dart';
import 'package:provider/provider.dart';

import 'individual_group_provider.dart';

class AddInputProvider extends ChangeNotifier {
  final TextEditingController inputController = TextEditingController();
  File? story;

  AddInputProvider() {
    inputController.addListener(notifyListeners);
  }

  void confirm(
    BuildContext context,
    void Function() onPressedGallery,
    void Function() onPressedCamera,
    String groupId,
  ) {
    if (inputController.text.isEmpty) return;
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const StaticText(
            text: 'Add a Photo or Video',
            textAlign: TextAlign.center,
            fontFamily: 'Montserrat-SemiBold',
            fontSize: TextSize.lBody,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: const StaticText(
            text:
                'Validate your data by adding \na media. If the majority of the group \nvalidates, your data will be \ntaking into account.',
            maxLines: 4,
            textAlign: TextAlign.center,
            fontSize: TextSize.mBody,
          ),
          actionsAlignment: MainAxisAlignment.center,
          contentPadding: const EdgeInsets.only(top: 20, bottom: 20),
          actions: [
            NextButton(
              text: 'Cancel',
              textColor: Colors.red,
              borderColor: Colors.transparent,
              onPressed: () => Navigator.of(context).pop(),
              color: Colors.transparent,
              height: 40,
              width: 140,
            ),
            NextButton(
              text: 'Add',
              borderColor: kPrimaryColor,
              onPressed: () {
                Navigator.pop(context);
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Insets.m),
                  ),
                  builder: (context) {
                    return Padding(
                      padding: MediaQuery.of(context).viewInsets,
                      child: Wrap(
                        children: <Widget>[
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.17,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: kDefaultPadding * 1.75),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ButtonCommonStyle(
                                        onPressed: onPressedGallery,
                                        child: const LargeBody(
                                          text: 'Choose from gallery',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      const SizedBox(height: Insets.l * 1.75),
                                      ButtonCommonStyle(
                                        onPressed: onPressedCamera,
                                        child: const LargeBody(
                                          text: 'Take photo',
                                          textAlign: TextAlign.center,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                );
                addInput(context, groupId);
              },
              height: 40,
              width: 140,
            ),
          ],
        );
      },
    );
  }

  Future<void> addInput(BuildContext context, String groupId) async {
    final user = Provider.of<AuthProvider>(context, listen: false).user;
    final individualGroupProvider =
        Provider.of<IndividualGroupProvider>(context, listen: false);
    final story = this.story;
    if (story == null) {
      return;
    }
    final url = await Provider.of<StorageProvider>(context, listen: false)
        .addStoryMedia(context, story);
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
            image: url,
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
