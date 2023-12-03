import 'package:flutter/material.dart';
import 'package:groupup/core/constants/design-system.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:groupup/core/widgets/texts/gu_text_header.dart';

class GPButton extends StatelessWidget {
  const GPButton({
    this.onPressed,
    this.text,
    this.borderColor = GPColors.primaryColor,
    this.color = GPColors.primaryColor,
    this.textColor = GPColors.white,
    this.height = 50,
    this.width = 140,
  });

  final void Function()? onPressed;
  final String? text;
  final Color borderColor;
  final Color color;
  final Color textColor;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        border: Border.all(
          color: onPressed == null ? GPColors.transparent : borderColor,
        ),
        borderRadius: BorderRadius.circular(Insets.s),
        color: onPressed == null ? GPColors.secondaryColor : color,
      ),
      child: ButtonCommonStyle(
        onPressed: onPressed,
        child: GUTextHeader(
          text: text ??
              AppLocalizations.of(
                context,
              ).next,
          color: textColor,
        ),
      ),
    );
  }
}
