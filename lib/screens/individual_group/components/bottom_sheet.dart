import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/general_group_info.dart';
import 'package:groupup/screens/edit_profile/components/text_field.dart';
import 'package:groupup/styles/text.dart';

class TopBarBottomSheet extends StatelessWidget {
  const TopBarBottomSheet({
    required this.generalGroupInfoModel,
    required this.title,
    required this.hint,
  });

  final GeneralGroupInfoModel generalGroupInfoModel;
  final String title;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: Insets.l),
          StandardTextStyle(text: title, fontSize: TextSize.subTitle),
          const SizedBox(height: Insets.l * 1.5),
          SizedBox(
            height: 60,
            child: TextFieldModel(
              hint: hint,
              maxLength: TextField.noMaxLength,
              border: InputBorder.none,
              hintColor: Colors.black,
              hintSize: TextSize.lBody,
            ),
          ),
          TextButton(
            onPressed: (() {
              Navigator.pop(context);
            }),
            child: const StandardTextStyle(
              text: 'OK',
              fontSize: TextSize.mBody,
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
