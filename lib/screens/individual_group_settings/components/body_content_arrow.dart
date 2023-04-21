import 'package:flutter/material.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/utils/icons/gp_icons.dart';
import 'package:groupup/core/widgets/icons/gp_icon.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/core/constants/design-system.dart';

class BodyContentArrow extends StatelessWidget {
  const BodyContentArrow({required this.name, this.maxLine = 1});

  final String name;
  final int maxLine;

  @override
  Widget build(BuildContext context) {
    final screenHeight = context.screenHeight;
    final screenWidth = context.screenWidth;
    final isVerySmallScreen = screenHeight < 600 || screenWidth < 350;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: isVerySmallScreen ? screenWidth * 0.675 : screenWidth * 0.65,
          child: StaticText(
            text: name,
            maxLines: maxLine,
            fontSize: TextSize.lBody,
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
