import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/styles/standard_text.dart';

class StartEndModel extends StatelessWidget {
  StartEndModel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StandardTextStyle(text: 'Start'),
        const SizedBox(
          height: kDefaultPadding / 2,
        ),
        StandardTextStyle(text: 'End'),
      ],
    );
  }
}
