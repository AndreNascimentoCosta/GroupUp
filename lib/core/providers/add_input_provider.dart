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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'individual_group_provider.dart';
import 'mix_panel_provider.dart';

class AddInputProvider extends ChangeNotifier {
  final TextEditingController inputController = TextEditingController();
  File? story;
  bool isLoading = false;

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
    if (int.tryParse(inputController.text) == 0) return;
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        final appLocalizations = AppLocalizations.of(context);
        return AlertDialog(
          title: StaticText(
            text: appLocalizations.addMedia,
            textAlign: TextAlign.center,
            fontFamily: 'Montserrat-SemiBold',
            fontSize: TextSize.lBody,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: StaticText(
            text: appLocalizations.validateMediaText,
            maxLines: 4,
            textAlign: TextAlign.center,
            fontSize: TextSize.mBody,
          ),
          actionsAlignment: MainAxisAlignment.center,
          contentPadding: const EdgeInsets.only(top: 20, bottom: 20),
          actions: [
            NextButton(
              text: appLocalizations.cancel,
              textColor: Colors.red,
              borderColor: Colors.transparent,
              onPressed: () {
                Provider.of<MixPanelProvider>(context, listen: false)
                    .logEvent(eventName: 'Cancel Media in Add Input');
                Navigator.of(context).pop();
              },
              color: Colors.transparent,
              height: 40,
              width: 140,
            ),
            NextButton(
              text: appLocalizations.add,
              borderColor: kPrimaryColor,
              onPressed: () {
                Provider.of<MixPanelProvider>(context, listen: false)
                    .logEvent(eventName: 'Add Media in Add Input');
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
                                    MediaQuery.of(context).size.height * 0.185,
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
                                        child: LargeBody(
                                          text: appLocalizations
                                              .chooseFromGallery,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      const SizedBox(height: Insets.l * 1.75),
                                      ButtonCommonStyle(
                                        onPressed: onPressedCamera,
                                        child: LargeBody(
                                          text: appLocalizations.takePhoto,
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

  Future<void> dataValidationYes(
    BuildContext context,
    String groupId,
    DateTime date,
    double value,
    String image,
    String participantId,
  ) async {
    final currentUser = Provider.of<AuthProvider>(context, listen: false).user;
    final individualGroupProvider =
        Provider.of<IndividualGroupProvider>(context, listen: false);
    if (currentUser == null) {
      return;
    }
    final group = await FirebaseFirestore.instance
        .collection('groups')
        .doc(groupId)
        .get();
    if (group.exists) {
      final groupData = group.data();
      if (groupData != null) {
        final participantsData =
            GroupModel.fromMap(group.id, groupData).participantsData;
        final userIndex = participantsData
            .indexWhere((element) => element.uid == participantId);
        if (userIndex != -1) {
          final inputDataIndex = participantsData[userIndex]
              .inputData
              .indexWhere((element) => element.date == date);
          final userParticipantData = participantsData[userIndex];
          if (userParticipantData.inputData[inputDataIndex].isValidated ==
              null) {
            userParticipantData.inputData[inputDataIndex].isValidated = {
              currentUser.id: true,
            };
          } else {
            userParticipantData
                .inputData[inputDataIndex].isValidated?[currentUser.id] = true;
          }
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

  Future<void> dataValidationNo(
    BuildContext context,
    String groupId,
    DateTime date,
    double value,
    String image,
    String participantId,
  ) async {
    final currentUser = Provider.of<AuthProvider>(context, listen: false).user;
    final individualGroupProvider =
        Provider.of<IndividualGroupProvider>(context, listen: false);
    if (currentUser == null) {
      return;
    }
    final group = await FirebaseFirestore.instance
        .collection('groups')
        .doc(groupId)
        .get();
    if (group.exists) {
      final groupData = group.data();
      if (groupData != null) {
        final participantsData =
            GroupModel.fromMap(group.id, groupData).participantsData;
        final userIndex = participantsData
            .indexWhere((element) => element.uid == participantId);
        if (userIndex != -1) {
          final inputDataIndex = participantsData[userIndex]
              .inputData
              .indexWhere((element) => element.date == date);
          final userParticipantData = participantsData[userIndex];
          if (userParticipantData.inputData[inputDataIndex].isValidated ==
              null) {
            userParticipantData.inputData[inputDataIndex].isValidated = {
              currentUser.id: false,
            };
          } else {
            userParticipantData
                .inputData[inputDataIndex].isValidated?[currentUser.id] = false;
          }
          if (userParticipantData.inputData[inputDataIndex].isValidated!.entries
                  .where((element) => element.value == false)
                  .toList()
                  .length >
              participantsData.length / 2) {
            userParticipantData.inputData.removeAt(inputDataIndex);
          }
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
                element.date.day == (DateTime.now()).toUtc().day &&
                element.date.month == (DateTime.now()).toUtc().month &&
                element.date.year == (DateTime.now()).toUtc().year,
          );
          final offset = await NTP.getNtpOffset(
              localTime: DateTime.now().toUtc(),
              lookUpAddress: "time.google.com");
          final internetTime =
              (DateTime.now()).toUtc().add(Duration(milliseconds: offset));
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

  void clean() {
    inputController.clear();
    notifyListeners();
  }
}
