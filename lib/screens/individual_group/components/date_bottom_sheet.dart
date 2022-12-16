import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/general_group_info.dart';
import 'package:groupup/styles/end_date_picker.dart';
import 'package:groupup/styles/start_date_picker.dart';
import 'package:groupup/styles/text.dart';

class DateBottomSheet extends StatelessWidget {
  const DateBottomSheet({
    required this.generalGroupInfoModel,
    required this.title,
  });

  final GeneralGroupInfoModel generalGroupInfoModel;
  final String title;

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
          Row(
            children: [
              const SizedBox(
                  width: 45,
                  child: StandardTextStyle(
                      text: 'Start', fontSize: TextSize.lBody)),
              const SizedBox(width: Insets.l),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: kDefaultPadding * 2.5),
                  child: StartDatePicker(
                    generalGroupInfoModel: generalGroupInfoModel,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: Insets.l),
          Row(
            children: [
              const SizedBox(
                  width: 45,
                  child:
                      StandardTextStyle(text: 'End', fontSize: TextSize.lBody)),
              const SizedBox(width: Insets.l),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: kDefaultPadding * 2.5),
                  child: EndDatePicker(
                    generalGroupInfoModel: generalGroupInfoModel,
                  ),
                ),
              )
            ],
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
