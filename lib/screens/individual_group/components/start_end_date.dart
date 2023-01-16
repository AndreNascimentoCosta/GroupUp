import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/group_model.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:intl/intl.dart';

class StartEndDateButton extends StatelessWidget {
  const StartEndDateButton({
    required this.builder,
    required this.groups,
  });

  final Widget builder;
  final GroupModel groups;

  @override
  Widget build(BuildContext context) {
    return ButtonCommonStyle(
      onPressed: () {
        showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Insets.m),
            ),
            builder: (context) {
              return builder;
            });
      },
      child: Row(
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
                      .format(groups.startDate ?? DateTime.now())),
              const SizedBox(height: kDefaultPadding / 2),
              StaticText(
                  text: DateFormat('dd/MM/yyyy')
                      .format(groups.endDate ?? DateTime.now())),
            ],
          ),
        ],
      ),
    );
  }
}
