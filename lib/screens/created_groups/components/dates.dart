import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/models/show_group.dart';
import 'package:intl/intl.dart';

class ShowDates extends StatelessWidget {
  const ShowDates({
    required this.showGroup,
  });

  final ShowGroupModel showGroup;

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
              text: DateFormat('dd/MM/yyyy').format(
                showGroup.startDate ?? DateTime.now(),
              ),
            ),
            const SizedBox(height: kDefaultPadding / 2),
            StaticText(
                text: DateFormat('dd/MM/yyyy')
                    .format(showGroup.endDate ?? DateTime.now(),)),
          ],
        ),
      ],
    );
  }
}
