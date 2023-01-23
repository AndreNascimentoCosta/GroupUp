import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/group_model.dart';
import 'package:groupup/screens/home/components/next_button.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/texts/static_text.dart';

class EditGroupNameProvider extends ChangeNotifier {
  final groupNameController = TextEditingController();

  EditGroupNameProvider(String initialText) {
    groupNameController.addListener(notifyListeners);
    groupNameController.text = initialText;
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
              .update({'projectName': value});
        }
      }
    }
    return '';
  }

  void Function()? done(
      BuildContext context, String groupName, String groupId) {
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
          Navigator.pop(context);
          await editGroupName(groupNameController.text, groupId);
          individualGroupProvider.getGroup(groupId);
        }
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
