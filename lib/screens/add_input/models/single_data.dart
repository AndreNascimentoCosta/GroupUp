import 'package:flutter/material.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/user_input_data.dart';
import 'package:groupup/styles/text.dart';
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
          child: StandardTextStyle(
            text: DateFormat('dd/MM/yyyy').format(userInputData.date),
            fontSize: TextSize.lBody,
          ),
        ),
        const SizedBox(width: Insets.l),
        Expanded(
          child: StandardTextStyle(
            text: userInputData.value.toString(),
            textAlign: TextAlign.center,
            fontSize: TextSize.lBody,
          ),
        ),
      ],
    );
  }
}
