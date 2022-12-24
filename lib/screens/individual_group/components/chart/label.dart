import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/user_information.dart';

class ChartLabel extends StatelessWidget {
  const ChartLabel({required this.individualGroup});

  final UserInformation individualGroup;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: kDefaultPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Row(
              children: [
                Container(
                  height: 10,
                  width: 10,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: kPrimaryColor,
                  ),
                ),
                const SizedBox(
                  width: Insets.s,
                ),
                StaticText(
                  text: individualGroup.name.isNotEmpty
                      ? "${individualGroup.name.trim().split(RegExp(' +')).map((s) => s[0]).take(2).join(". ")}."
                      : '',
                  color: kPrimaryColor,
                  fontSize: TextSize.sBody,
                ),
              ],
            ),
          ),
          Flexible(
            child: Row(
              children: [
                Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: kSecondaryColor,
                      width: 1,
                    ),
                  ),
                ),
                const SizedBox(
                  width: Insets.s,
                ),
                const StaticText(
                  text: 'Me',
                  color: kSecondaryColor,
                  fontSize: TextSize.sBody,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
