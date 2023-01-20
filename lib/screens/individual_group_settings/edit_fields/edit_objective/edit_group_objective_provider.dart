import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/group_model.dart';
import 'package:groupup/screens/home/components/next_button.dart';
import 'package:groupup/screens/individual_group/components/individual_group_provider.dart';
import 'package:provider/provider.dart';

import '../../../../core/widgets/texts/static_text.dart';

class EditGroupObjectiveProvider extends ChangeNotifier {
  final groupObjectiveController = TextEditingController();

  EditGroupObjectiveProvider(String initialText) {
    groupObjectiveController.addListener(notifyListeners);
    groupObjectiveController.text = initialText;
  }

  final newGroup = GroupModel.empty();

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

  void Function()? done(BuildContext context, String groupObjective, String groupId) {
    final groupObjectiveControllerText = groupObjectiveController.text;

    if ((groupObjectiveControllerText.isEmpty || groupObjectiveControllerText == groupObjective)) {
      return null;
    } else {
      return () async {
        final individualGroupProvider = Provider.of<IndividualGroupProvider>(
          context,
          listen: false,
        );
        Navigator.pop(context);
        await editGroupObjective(groupObjectiveController.text, groupId);
        individualGroupProvider.getGroup(groupId);
      };
    }
  }

  void confirmDiscard(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext newContext) {
        FocusScope.of(context).unfocus();
        return AlertDialog(
          title: const StaticText(
            text: 'Discard changes?',
            textAlign: TextAlign.center,
            fontFamily: 'Montserrat-SemiBold',
            fontSize: TextSize.lBody,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: const StaticText(
            text: 'Are you sure you want to lose your changes?',
            maxLines: 2,
            textAlign: TextAlign.center,
            fontSize: TextSize.mBody,
          ),
          actionsAlignment: MainAxisAlignment.center,
          contentPadding: const EdgeInsets.only(top: 20, bottom: 20),
          actions: [
            NextButton(
              text: 'Yes, discard',
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
              text: 'No, keep',
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
