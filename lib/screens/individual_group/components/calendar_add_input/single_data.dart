import 'package:flutter/material.dart';
import 'package:groupup/core/constants/design-system.dart';
import 'package:groupup/core/widgets/texts/gu_text_body.dart';
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
          child: GUTextBody(
            text: DateFormat.yMd(
              Localizations.localeOf(context).toLanguageTag(),
            ).format(userInputData.date),
            minFontSize: 16,
            maxFontSize: 18,
          ),
        ),
        const SizedBox(width: Insets.l),
        Expanded(
          child: GUTextBody(
            text: userInputData.value.toString(),
            textAlign: TextAlign.center,
            minFontSize: 16,
            maxFontSize: 18,
          ),
        ),
      ],
    );
  }
}
