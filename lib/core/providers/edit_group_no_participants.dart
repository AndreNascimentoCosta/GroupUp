import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';
import 'package:groupup/core/widgets/texts/gp_text_header.dart';
import 'package:groupup/models/group_model.dart';
import 'package:groupup/core/widgets/buttons/gp_button.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  void Function()? done(BuildContext context, String groupMaxParticipants,
      String groupId, int groupParticipantsLength) {
    final groupObjectiveControllerText = groupMaxParticipantsController.text;

    if ((groupObjectiveControllerText.isEmpty ||
        groupObjectiveControllerText == groupMaxParticipants ||
        (int.tryParse(groupObjectiveControllerText) ?? 0) > 50)) {
      return null;
    } else if (int.tryParse(groupObjectiveControllerText)! <
        groupParticipantsLength) {
      return null;
    } else {
      return () async {
        final individualGroupProvider = Provider.of<IndividualGroupProvider>(
          context,
          listen: false,
        );
        Provider.of<MixPanelProvider>(context, listen: false)
            .logEvent(eventName: 'Edit Group No Participants');
        Navigator.pop(context);
        await editGroupObjective(
            int.parse(groupMaxParticipantsController.text), groupId);
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
          title: GPTextHeader(
            text: appLocalizations.discardChangesQuestion,
            textAlign: TextAlign.center,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: GPTextBody(
              text: appLocalizations.areYouSureToDiscardChanges,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          contentPadding: const EdgeInsets.only(top: 20, bottom: 20),
          actions: [
            GPButton(
              text: appLocalizations.yesDiscard,
              textColor: GPColors.red,
              borderColor: GPColors.transparent,
              onPressed: () {
                Provider.of<MixPanelProvider>(context, listen: false).logEvent(
                    eventName: 'Discard Changes in Edit Group No Participants');
                Navigator.pop(newContext);
                Navigator.pop(context);
              },
              color: GPColors.transparent,
              height: 40,
              width: 140,
            ),
            GPButton(
              text: appLocalizations.noKeep,
              borderColor: GPColors.primaryColor,
              onPressed: () {
                Provider.of<MixPanelProvider>(context, listen: false).logEvent(
                    eventName: 'Keep Changes in Edit Group No Participants');
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
