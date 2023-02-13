import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/group_model.dart';
import 'package:groupup/screens/home/components/next_button.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/texts/static_text.dart';

class EditGroupNoParticipantsProvider extends ChangeNotifier {
  final groupMaxParticipantsController = TextEditingController();

  EditGroupNoParticipantsProvider(String initialText) {
    groupMaxParticipantsController.addListener(notifyListeners);
    groupMaxParticipantsController.text = initialText;
  }

  final newGroup = GroupModel.empty();

  Future<String> editGroupObjective(int value, String groupId) async {
    final group = await FirebaseFirestore.instance
        .collection('groups')
        .doc(groupId)
        .get();
    if (group.exists) {
      final groupData = group.data();
      if (groupData != null) {
        final groupMaxParticipants = groupData['noParticipants'];
        newGroup.maxParticipants = value;
        if (groupMaxParticipants != value) {
          await FirebaseFirestore.instance
              .collection('groups')
              .doc(groupId)
              .update({'noParticipants': value});
        }
      }
    }
    return '';
  }

  void Function()? done(
      BuildContext context, String groupMaxParticipants, String groupId) {
    final groupObjectiveControllerText = groupMaxParticipantsController.text;

    if ((groupObjectiveControllerText.isEmpty ||
        groupObjectiveControllerText == groupMaxParticipants ||
        (int.tryParse(groupObjectiveControllerText) ?? 0) > 50)) {
      return null;
    } else {
      return () async {
        final individualGroupProvider = Provider.of<IndividualGroupProvider>(
          context,
          listen: false,
        );
        Navigator.pop(context);
        await editGroupObjective(int.parse(groupMaxParticipantsController.text), groupId);
        individualGroupProvider.getGroup(groupId);
      };
    }
  }

  void confirmDiscard(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext newContext) {
        final appLocalizations = AppLocalizations.of(context);
        FocusScope.of(context).unfocus();
        return AlertDialog(
          title: StaticText(
            text: appLocalizations.discardChangesQuestion,
            textAlign: TextAlign.center,
            fontFamily: 'Montserrat-SemiBold',
            fontSize: TextSize.lBody,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: StaticText(
            text: appLocalizations.areYouSureToDiscardChanges,
            maxLines: 2,
            textAlign: TextAlign.center,
            fontSize: TextSize.mBody,
          ),
          actionsAlignment: MainAxisAlignment.center,
          contentPadding: const EdgeInsets.only(top: 20, bottom: 20),
          actions: [
            NextButton(
              text: appLocalizations.yesDiscard,
              textColor: Colors.red,
              borderColor: Colors.transparent,
              onPressed: () {
                Navigator.pop(newContext);
                Navigator.pop(context);
              },
              color: Colors.transparent,
              height: 40,
              width: 140,
            ),
            NextButton(
              text: appLocalizations.noKeep,
              borderColor: kPrimaryColor,
              onPressed: () {
                Navigator.of(newContext).pop();
                FocusScope.of(context).requestFocus();
              },
              height: 40,
              width: 140,
            ),
          ],
        );
      },
    );
  }
}