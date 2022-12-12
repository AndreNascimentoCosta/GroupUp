import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/models/general_group_info.dart';
import 'package:groupup/styles/standard_text.dart';
import 'package:intl/intl.dart';

class StartEndDateModel extends StatelessWidget {
  const StartEndDateModel({required this.generalGroupInfoModel});

  final GeneralGroupInfoModel generalGroupInfoModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StandardTextStyle(text: DateFormat('dd/MM/yyyy').format(generalGroupInfoModel.startDate)),
        const SizedBox(
          height: kDefaultPadding / 2,
        ),
        StandardTextStyle(text: DateFormat('dd/MM/yyyy').format(generalGroupInfoModel.endDate)),
      ],
    );
  }
}
