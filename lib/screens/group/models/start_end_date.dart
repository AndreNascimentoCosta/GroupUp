import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/models/general_group_info.dart';
import 'package:groupup/styles/button.dart';
import 'package:groupup/styles/text.dart';
import 'package:intl/intl.dart';

class StartEndDateModel extends StatelessWidget {
  const StartEndDateModel(
      {required this.generalGroupInfoModel, required this.onPressed});

  final GeneralGroupInfoModel generalGroupInfoModel;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ButtonCommonStyle(
      onPressed: onPressed,
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              StandardTextStyle(text: 'Start'),
              SizedBox(height: kDefaultPadding / 2),
              StandardTextStyle(text: 'End'),
            ],
          ),
          const SizedBox(width: kDefaultPadding / 1.75),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StandardTextStyle(
                  text: DateFormat('dd/MM/yyyy')
                      .format(generalGroupInfoModel.startDate)),
              const SizedBox(height: kDefaultPadding / 2),
              StandardTextStyle(
                  text: DateFormat('dd/MM/yyyy')
                      .format(generalGroupInfoModel.endDate)),
            ],
          ),
        ],
      ),
    );
  }
}
