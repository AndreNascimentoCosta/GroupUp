import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/core/widgets/buttons/button.dart';

class ShareButton extends StatelessWidget {
  const ShareButton({
    required this.text,
    required this.onPressed,
  });

  final String text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenHeight < 800 || screenWidth < 350;
    final isVerySmallScreen = screenHeight < 600 || screenWidth < 300;
    return ButtonCommonStyle(
      onPressed: onPressed,
      child: Container(
        height: isVerySmallScreen
            ? screenHeight * 0.09
            : isSmallScreen
                ? screenHeight * 0.08
                : screenHeight * 0.06,
        width: isVerySmallScreen
            ? screenWidth * 0.45
            : isSmallScreen
                ? screenWidth * 0.4
                : screenWidth * 0.35,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(Insets.m),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              spreadRadius: 0,
              blurRadius: 5,
              offset: const Offset(1.5, 2.5),
              color: kSecondaryColor.withOpacity(0.3),
            )
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: Insets.s),
              child: SizedBox(
                width: isVerySmallScreen
                    ? screenWidth * 0.275
                    : isSmallScreen
                        ? screenWidth * 0.25
                        : screenWidth * 0.2,
                child: StaticText(
                  text: text,
                  textAlign: TextAlign.center,
                  fontSize: TextSize.lBody,
                ),
              ),
            ),
            const Expanded(
              child: Icon(
                Icons.ios_share_rounded,
                color: Colors.black,
                size: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
