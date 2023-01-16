import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/header.dart';
import 'package:groupup/core/widgets/texts/large_body.dart';
import 'package:groupup/core/widgets/texts/medium_body.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/group_model.dart';
import 'package:groupup/styles/end_date_picker.dart';
import 'package:groupup/styles/start_date_picker.dart';

class DateBottomSheet extends StatelessWidget {
  const DateBottomSheet({
    required this.groups,
    required this.title,
  });

  final GroupModel groups;
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
          Header(
            text: title,
            textAlign: TextAlign.center,
            fontFamily: 'Montserrat-Medium',
          ),
          const SizedBox(height: Insets.l),
          Row(
            children: [
              const SizedBox(width: 45, child: LargeBody(text: 'Start')),
              const SizedBox(width: Insets.l),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: kDefaultPadding * 2.5),
                  child: StartDatePicker(
                    groups: groups,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: Insets.l),
          Row(
            children: [
              const SizedBox(width: 45, child: LargeBody(text: 'End')),
              const SizedBox(width: Insets.l),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: kDefaultPadding * 2.5),
                  child: EndDatePicker(
                    groups: groups,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: Insets.xs),
          TextButton(
            onPressed: (() {
              Navigator.pop(context);
            }),
            child: const MediumBody(text: 'OK', color: kPrimaryColor),
          ),
        ],
      ),
    );
  }
}
