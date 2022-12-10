import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/models/top_bar_individual_group.dart';
import 'package:groupup/styles/standard_text.dart';
import 'package:intl/intl.dart';

class StartEndDateModel extends StatelessWidget {
  const StartEndDateModel({required this.topBarIndividualGroup});

  final TopBarIndividualGroupModel topBarIndividualGroup;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StandardTextStyle(text: DateFormat('dd/MM/yyyy').format(topBarIndividualGroup.startDate)),
        const SizedBox(
          height: kDefaultPadding / 2,
        ),
        StandardTextStyle(text: DateFormat('dd/MM/yyyy').format(topBarIndividualGroup.endDate)),
      ],
    );
  }
}
