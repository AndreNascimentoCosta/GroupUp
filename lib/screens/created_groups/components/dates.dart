import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/models/general_group_info.dart';
import 'package:intl/intl.dart';

class ShowDates extends StatelessWidget {
  const ShowDates({
    required this.generalGroupInfoModel,
  });

  final GeneralGroupInfoModel generalGroupInfoModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            StaticText(text: 'Start'),
            SizedBox(height: kDefaultPadding / 2),
            StaticText(text: 'End'),
          ],
        ),
        const SizedBox(width: kDefaultPadding / 1.75),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StaticText(
                text: DateFormat('dd/MM/yyyy')
                    .format(generalGroupInfoModel.startDate)),
            const SizedBox(height: kDefaultPadding / 2),
            StaticText(
                text: DateFormat('dd/MM/yyyy')
                    .format(generalGroupInfoModel.endDate)),
          ],
        ),
      ],
    );
  }
}