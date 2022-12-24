import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/header.dart';
import 'package:groupup/core/widgets/texts/medium_body.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/general_group_info.dart';
import 'package:groupup/screens/edit_profile/components/text_field.dart';

class HeaderBottomSheet extends StatelessWidget {
  const HeaderBottomSheet({
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
          Header(
            text: title,
            textAlign: TextAlign.center,
            fontFamily: 'Montserrat-Medium',
          ),
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
            child: const MediumBody(
              text: 'OK',
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
