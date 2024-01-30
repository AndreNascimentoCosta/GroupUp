import 'package:flutter/material.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/constants/design-system.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';

class ShareButton extends StatelessWidget {
  const ShareButton({
    required this.text,
    required this.onPressed,
  });

  final String text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = context.screenHeight < 800 || context.screenWidth < 350;
    final isVerySmallScreen = context.screenHeight < 600 || context.screenWidth < 300;
    return ButtonCommonStyle(
      onPressed: onPressed,
      child: Container(
        height: isVerySmallScreen
            ? context.screenHeight * 0.09
            : isSmallScreen
                ? context.screenHeight * 0.08
                : context.screenHeight * 0.06,
        width: isVerySmallScreen ? context.screenWidth * 0.45 : context.screenWidth * 0.4,
        decoration: BoxDecoration(
          border: Border.all(color: GPColors.white),
          borderRadius: BorderRadius.circular(Insets.m),
          color: GPColors.white,
          boxShadow: [
            BoxShadow(
              spreadRadius: 0,
              blurRadius: 5,
              offset: const Offset(1.5, 2.5),
              color: GPColors.secondaryColor.withOpacity(0.3),
            )
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: Insets.s),
              child: SizedBox(
                width: isVerySmallScreen
                    ? context.screenWidth * 0.275
                    : context.screenWidth * 0.25,
                child: GPTextBody(
                  text: text,
                  textAlign: TextAlign.center,
                  fontSize: 18,
                ),
              ),
            ),
            const Expanded(
              child: Icon(
                Icons.ios_share_rounded,
                color: GPColors.black,
                size: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
