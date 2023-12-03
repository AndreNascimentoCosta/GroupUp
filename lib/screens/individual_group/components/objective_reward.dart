import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/widgets/texts/gu_text_body.dart';

class ObjectiveRewardModel extends StatelessWidget {
  const ObjectiveRewardModel({
    required this.icon,
    required this.text,
  });

  final String icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          icon,
          color: GPColors.black,
        ),
        const SizedBox(height: kDefaultPadding / 2),
        SizedBox(
          width: 65,
          child: GUTextBody(
            text: Characters(text)
                .replaceAll(
                  Characters(''),
                  Characters('\u{200B}'),
                )
                .toString(),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
