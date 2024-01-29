import 'package:flutter/material.dart';
import 'package:groupup/core/constants/design-system.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';
import 'package:groupup/models/user_input_data.dart';
import 'package:intl/intl.dart';

class SingleData extends StatelessWidget {
  const SingleData({required this.userInputData});

  final UserInputData userInputData;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: GPTextBody(
            text: DateFormat.yMd(
              Localizations.localeOf(context).toLanguageTag(),
            ).format(userInputData.date),
            fontSize: 16,
          ),
        ),
        const SizedBox(width: Insets.l),
        Expanded(
          child: GPTextBody(
            text: userInputData.value.toString(),
            textAlign: TextAlign.center,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
