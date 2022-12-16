import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/general_group_info.dart';
import 'package:groupup/screens/edit_profile/components/text_field.dart';
import 'package:groupup/styles/text.dart';

class AlertDialogModel extends StatelessWidget {
  const AlertDialogModel({
    required this.generalGroupInfoModel,
    required this.title,
    required this.hint,
  });

  final GeneralGroupInfoModel generalGroupInfoModel;
  final String title;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: StandardTextStyle(text: title, fontSize: TextSize.subTitle),
      contentPadding: const EdgeInsets.only(
        top: kDefaultPadding,
        bottom: 0,
        right: kDefaultPadding,
        left: kDefaultPadding * 1.25,
      ),
      content: TextFieldModel(
        hint: hint,
        maxLength: TextField.noMaxLength,
        border: InputBorder.none,
        hintColor: Colors.black,
        hintSize: TextSize.lBody,
      ),
      actionsPadding: const EdgeInsets.symmetric(vertical: 0),
      actions: [
        TextButton(
            onPressed: (() {
              Navigator.pop(context);
            }),
            child: const StandardTextStyle(
              text: 'OK',
              fontSize: TextSize.mBody,
              color: kPrimaryColor,
            ))
      ],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
    ;
  }
}
