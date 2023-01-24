import 'package:flutter/material.dart';
import 'package:groupup/core/widgets/texts/large_body.dart';
import 'package:groupup/design-system.dart';
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
          child: LargeBody(
              text: DateFormat('dd/MM/yyyy').format(userInputData.date)),
        ),
        const SizedBox(width: Insets.l),
        Expanded(
          child: LargeBody(
            text: userInputData.value.toString(),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}