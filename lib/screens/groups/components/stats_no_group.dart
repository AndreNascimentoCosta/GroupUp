import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/widgets/texts/medium_body.dart';
import 'package:groupup/design-system.dart';
import '../../../constants.dart';

class StatsNoGroup extends StatelessWidget {
  const StatsNoGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  'assets/icons/rank.svg',
                  height: Insets.l,
                  width: Insets.l,
                  color: GPColors.secondaryColor,
                ),
                const SizedBox(
                  height: kDefaultPadding * 0.25,
                ),
                SvgPicture.asset(
                  'assets/icons/daysgone.svg',
                  height: Insets.l,
                  width: Insets.l,
                  color: GPColors.secondaryColor,
                ),
                const SizedBox(
                  height: kDefaultPadding * 0.25,
                ),
                SvgPicture.asset(
                  'assets/icons/daysleft.svg',
                  height: Insets.l,
                  width: Insets.l,
                  color: GPColors.secondaryColor,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: Insets.l,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              MediumBody(
                text: '-',
                textAlign: TextAlign.center,
                color: GPColors.secondaryColor,
              ),
              SizedBox(
                height: kDefaultPadding * 0.25,
              ),
              MediumBody(
                text: '-',
                textAlign: TextAlign.center,
                color: GPColors.secondaryColor,
              ),
              SizedBox(
                height: kDefaultPadding * 0.25,
              ),
              MediumBody(
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
