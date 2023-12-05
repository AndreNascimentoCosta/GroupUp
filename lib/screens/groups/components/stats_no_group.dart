import 'package:flutter/material.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/utils/icons/gp_icons.dart';
import 'package:groupup/core/widgets/icons/gp_icon.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';
import 'package:groupup/core/constants/design-system.dart';
import '../../../core/constants/constants.dart';

class StatsNoGroup extends StatelessWidget {
  const StatsNoGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: kDefaultPadding,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GPIcon(
                  GPIcons.rank,
                  color: GPColors.secondaryColor,
                  height: Insets.l,
                  width: Insets.l,
                ),
                SizedBox(
                  height: kDefaultPadding * 0.25,
                ),
                GPIcon(
                  GPIcons.daysGone,
                  color: GPColors.secondaryColor,
                  height: Insets.l,
                  width: Insets.l,
                ),
                SizedBox(
                  height: kDefaultPadding * 0.25,
                ),
                GPIcon(
                  GPIcons.daysLeft,
                  color: GPColors.secondaryColor,
                  height: Insets.l,
                  width: Insets.l,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: Insets.l,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GPTextBody(
                text: '-',
                textAlign: TextAlign.center,
                color: GPColors.secondaryColor,
              ),
              SizedBox(
                height: kDefaultPadding * 0.25,
              ),
              GPTextBody(
                text: '-',
                textAlign: TextAlign.center,
                color: GPColors.secondaryColor,
              ),
              SizedBox(
                height: kDefaultPadding * 0.25,
              ),
              GPTextBody(
                text: '-',
                textAlign: TextAlign.center,
                color: GPColors.secondaryColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
