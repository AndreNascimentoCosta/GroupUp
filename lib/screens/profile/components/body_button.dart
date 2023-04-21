import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/utils/icons/gp_icons.dart';
import 'package:groupup/core/widgets/icons/gp_icon.dart';
import 'package:groupup/core/widgets/texts/large_body.dart';
import 'package:groupup/core/constants/design-system.dart';
import 'package:groupup/core/widgets/buttons/button.dart';

class BodyButtonModel extends StatelessWidget {
  const BodyButtonModel(
      {required this.text,
      required this.secondaryText,
      required this.onPressed});

  final String text;
  final String secondaryText;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ButtonCommonStyle(
      onPressed: onPressed,
      child: Row(
        children: [
          LargeBody(text: text),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: kDefaultPadding),
            child: LargeBody(
                text:
                    secondaryText), // StandardTextStyle(text: secondaryText, fontSize: 18),
          ),
          const GPIcon(
            GPIcons.arrowRight,
            height: Insets.l,
            width: Insets.l,
          ),
        ],
      ),
    );
  }
}
