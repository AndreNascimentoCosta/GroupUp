import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/constants/design-system.dart';
import 'package:groupup/models/group_model.dart';
import 'package:groupup/core/widgets/buttons/gp_button.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/texts/static_text.dart';

class EditGroupDatesProvider extends ChangeNotifier {
  final controllerStartDate = TextEditingController();
  final controllerEndDate = TextEditingController();

  final newGroup = GroupModel.empty();

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

  void Function()? done(BuildContext context, DateTime? startDate,
      DateTime? endDate, String groupId) {
    if ((startDate == null && endDate == null)) {
      return null;
    } else {
      return () async {
        {
          final individualGroupProvider = Provider.of<IndividualGroupProvider>(
            context,
            listen: false,
          );
          Provider.of<MixPanelProvider>(context, listen: false)
              .logEvent(eventName: 'Edit Group Dates');
          Navigator.pop(context);
          await editGroupDates(groupId);
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
            GPButton(
              text: appLocalizations.yesDiscard,
              textColor: GPColors.red,
              borderColor: GPColors.transparent,
              onPressed: () {
                clean();
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
