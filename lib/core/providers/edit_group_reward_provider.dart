import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/group_model.dart';
import 'package:groupup/screens/home/components/next_button.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/texts/static_text.dart';

class EditGroupRewardProvider extends ChangeNotifier {
  final groupRewardController = TextEditingController();

  EditGroupRewardProvider(String initialText) {
    groupRewardController.addListener(notifyListeners);
    groupRewardController.text = initialText;
  }

  final newGroup = GroupModel.empty();

  Future<String> editGroupReward(String value, String groupId) async {
    final group = await FirebaseFirestore.instance
        .collection('groups')
        .doc(groupId)
        .get();
    if (group.exists) {
      final groupData = group.data();
      if (groupData != null) {
        final editGroupReward = groupData['reward'] as String;
        newGroup.reward = value;
        if (editGroupReward != value) {
          await FirebaseFirestore.instance
              .collection('groups')
              .doc(groupId)
              .update({'reward': value});
        }
      }
    }
    return '';
  }

  void Function()? done(
      BuildContext context, String groupReward, String groupId) {
    final groupRewardText = groupRewardController.text;

    if ((groupRewardText.isEmpty || groupRewardText == groupReward)) {
      return null;
    } else {
      return () async {
        {
          final individualGroupProvider = Provider.of<IndividualGroupProvider>(
            context,
            listen: false,
          );
          Provider.of<MixPanelProvider>(context, listen: false)
              .logEvent(eventName: 'Edit Group Reward');
          Navigator.pop(context);
          await editGroupReward(groupRewardController.text, groupId);
          individualGroupProvider.getGroup(groupId);
        }
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
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: StaticText(
              text: appLocalizations.areYouSureToDiscardChanges,
              maxLines: 2,
              textAlign: TextAlign.center,
              fontSize: TextSize.mBody,
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          contentPadding: const EdgeInsets.only(top: 20, bottom: 20),
          actions: [
            NextButton(
              text: appLocalizations.yesDiscard,
              textColor: Colors.red,
              borderColor: Colors.transparent,
              onPressed: () {
                Provider.of<MixPanelProvider>(context, listen: false)
                    .logEvent(eventName: 'Discard Changes in Edit Group Reward');
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
                Provider.of<MixPanelProvider>(context, listen: false)
                    .logEvent(eventName: 'Keep Changes in Edit Group Reward');
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