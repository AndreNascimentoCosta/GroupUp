import 'package:flutter/material.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/core/constants/design-system.dart';

class LoginButtonStyle extends StatelessWidget {
  const LoginButtonStyle({
    required this.text,
    this.withIcon = true,
    super.key,
  });

  final String text;
  final bool withIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: GPColors.black,
        ),
        borderRadius: BorderRadius.circular(
          Insets.l,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Row(
          children: [
            if (withIcon)
              Image.asset(
                'assets/icons/google_icon.png',
                height: 35,
                width: 31,
              ),
            Expanded(
              child: StaticText(
                text: text,
                fontSize: 18.92,
                textAlign: TextAlign.center,
              ),
            ),
            if (withIcon)
              const SizedBox(
                width: 28,
              ),
          ],
        ),
      ),
    );
  }
}
