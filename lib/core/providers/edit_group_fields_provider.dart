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
import 'package:groupup/modules/individual_group_settings/components/individual_group_settings_events.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditGroupFieldsProvider extends ChangeNotifier {
  final groupNameController = TextEditingController();
  final groupObjectiveController = TextEditingController();
  final groupMaxParticipantsController = TextEditingController();
  final groupRewardController = TextEditingController();
  final controllerStartDate = TextEditingController();
  final controllerEndDate = TextEditingController();

  EditGroupFieldsProvider();

  EditGroupFieldsProvider.groupName(String initialText) {
    groupNameController.addListener(notifyListeners);
    groupNameController.text = initialText;
  }

  EditGroupFieldsProvider.groupObjective(String initialText) {
    groupObjectiveController.addListener(notifyListeners);
    groupObjectiveController.text = initialText;
  }

  EditGroupFieldsProvider.groupMaxParticipants(String initialText) {
    groupMaxParticipantsController.addListener(notifyListeners);
    groupMaxParticipantsController.text = initialText;
  }

  EditGroupFieldsProvider.groupReward(String initialText) {
    groupRewardController.addListener(notifyListeners);
    groupRewardController.text = initialText;
  }

  final newGroup = GroupModel.empty();

  Future<String> editGroupName(String value, String groupId) async {
    final group = await FirebaseFirestore.instance
        .collection('groups')
        .doc(groupId)
        .get();
    if (group.exists) {
      final groupData = group.data();
      if (groupData != null) {
        final editGroupName = groupData['projectName'] as String;
        newGroup.projectName = value;
        if (editGroupName != value) {
          await FirebaseFirestore.instance
              .collection('groups')
              .doc(groupId)
              .update(
            {'projectName': value},
          );
        }
      }
    }
    return '';
  }

  void Function()? doneEditGroupName(
    BuildContext context,
    String groupName,
    String groupId,
  ) {
    final groupNameText = groupNameController.text;

    if ((groupNameText.isEmpty || groupNameText == groupName)) {
      return null;
    } else {
      return () async {
        {
          final individualGroupProvider = Provider.of<IndividualGroupProvider>(
            context,
            listen: false,
          );
          Provider.of<MixPanelProvider>(context, listen: false)
              .logEvent(eventName: 'Edit Group Name');
          Navigator.pop(context);
          await editGroupName(groupNameController.text, groupId);
          individualGroupProvider.getGroup(groupId);
        }
      };
    }
  }

  Future<String> editNoParticipants(int value, String groupId) async {
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

  void Function()? doneEditNoParticipants(
      BuildContext context,
      String groupMaxParticipants,
      String groupId,
      int groupParticipantsLength) {
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
        await editNoParticipants(
            int.parse(groupMaxParticipantsController.text), groupId);
        individualGroupProvider.getGroup(groupId);
      };
    }
  }

  Future<String> editGroupObjective(String value, String groupId) async {
    final group = await FirebaseFirestore.instance
        .collection('groups')
        .doc(groupId)
        .get();
    if (group.exists) {
      final groupData = group.data();
      if (groupData != null) {
        final editGroupObjective = groupData['objective'] as String;
        newGroup.objective = value;
        if (editGroupObjective != value) {
          await FirebaseFirestore.instance
              .collection('groups')
              .doc(groupId)
              .update({'objective': value});
        }
      }
    }
    return '';
  }

  void Function()? doneEditGroupObjective(
      BuildContext context, String groupObjective, String groupId) {
    final groupObjectiveControllerText = groupObjectiveController.text;

    if ((groupObjectiveControllerText.isEmpty ||
        groupObjectiveControllerText == groupObjective)) {
      return null;
    } else {
      return () async {
        final individualGroupProvider = Provider.of<IndividualGroupProvider>(
          context,
          listen: false,
        );
        Provider.of<MixPanelProvider>(context, listen: false)
            .logEvent(eventName: 'Edit Group Objective');
        Navigator.pop(context);
        await editGroupObjective(groupObjectiveController.text, groupId);
        individualGroupProvider.getGroup(groupId);
      };
    }
  }

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

  void Function()? doneEditGroupReward(
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

  Future<void> editGroupDates(String groupId) async {
    final group = await FirebaseFirestore.instance
        .collection('groups')
        .doc(groupId)
        .get();
    if (group.exists) {
      final groupData = group.data();
      if (groupData != null) {
        final editGroupStartDate = groupData['startDate'].toDate();
        final editGroupEndDate = groupData['endDate'].toDate();
        newGroup.startDate ??= editGroupStartDate;
        if (editGroupStartDate != newGroup.startDate) {
          await FirebaseFirestore.instance
              .collection('groups')
              .doc(groupId)
              .update(
            {'startDate': newGroup.startDate},
          );
        }
        newGroup.endDate ??= editGroupEndDate;
        if (editGroupEndDate != newGroup.endDate) {
          await FirebaseFirestore.instance
              .collection('groups')
              .doc(groupId)
              .update(
            {'endDate': newGroup.endDate},
          );
        }
      }
    }
  }

  void Function()? doneEditGroupDates(
    BuildContext context,
    DateTime? startDate,
    DateTime? endDate,
    String groupId,
  ) {
    if ((startDate == null && endDate == null)) {
      return null;
    } else {
      return () async {
        {
          final individualGroupProvider = Provider.of<IndividualGroupProvider>(
            context,
            listen: false,
          );
          Provider.of<MixPanelProvider>(context, listen: false).logEvent(
            eventName: IndividualGroupSettingsEvents.editGroupDates.value,
          );
          Navigator.pop(context);
          await editGroupDates(groupId);
          individualGroupProvider.getGroup(groupId);
        }
      };
    }
  }

  void confirmDiscard(
      BuildContext context, String discardEventName, String keepEventName) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext newContext) {
        final appLocalizations = AppLocalizations.of(context)!;
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
                Provider.of<MixPanelProvider>(context, listen: false)
                    .logEvent(eventName: discardEventName);
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
                Provider.of<MixPanelProvider>(context, listen: false)
                    .logEvent(eventName: keepEventName);
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

  void clean() {
    controllerStartDate.clear();
    controllerEndDate.clear();
  }
}
