import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/constants/design-system.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:groupup/core/widgets/texts/gu_text_header.dart';

class ContinueButton extends StatelessWidget {
  const ContinueButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        right: kDefaultPadding * 1.25,
        left: kDefaultPadding,
      ),
      height: context.screenHeight * 0.085,
      width: context.screenWidth * 0.7,
      decoration: BoxDecoration(
        color: GPColors.primaryColor,
        borderRadius: BorderRadius.circular(
          Insets.l,
        ),
        boxShadow: [
          BoxShadow(
            color: GPColors.black.withOpacity(
              0.25,
            ),
            offset: const Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      alignment: Alignment.center,
      child: GUTextHeader(
        text: AppLocalizations.of(context).getStarted,
        color: GPColors.white,
      ),
    );
  }
}
