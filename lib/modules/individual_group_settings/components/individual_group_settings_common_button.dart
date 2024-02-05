import 'package:flutter/material.dart';
import 'package:groupup/core/constants/design_system.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/utils/icons/gp_icons.dart';
import 'package:groupup/core/widgets/icons/gp_icon.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';

class IndividualGroupSettingCommonButton extends StatelessWidget {
  const IndividualGroupSettingCommonButton({required this.name, this.maxLine = 1});

  final String name;
  final int maxLine;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: context.isVerySmallScreen ? context.screenWidth * 0.675 : context.screenWidth * 0.65,
          child: GPTextBody(
            text: name,
            maxLines: maxLine,
            fontSize: 20,
          ),
        ),
        const Spacer(),
        const SizedBox(
          width: 60,
          child: GPIcon(
            GPIcons.arrowRight,
            color: GPColors.black,
            height: Insets.l,
            width: Insets.l,
          ),
        ),
      ],
    );
  }
}
