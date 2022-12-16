import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/styles/text.dart';

class ChartLabel extends StatelessWidget {
  const ChartLabel({super.key});

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
                const StandardTextStyle(
                  text: 'H. C.',
                  fontSize: TextSize.sBody,
                  color: kPrimaryColor,
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
                const StandardTextStyle(
                  text: 'Me',
                  fontSize: TextSize.sBody,
                  color: kSecondaryColor,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
