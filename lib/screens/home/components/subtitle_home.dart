import 'package:flutter/material.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SubtitleHome extends StatelessWidget {
  const SubtitleHome({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
          color: GPColors.black,
          fontSize: context.screenHeight * 0.033,
          fontFamily: 'Montserrat-Medium',
        ),
        children: [
          TextSpan(
            text: AppLocalizations.of(context)!.createHS,
            style: const TextStyle(
              fontFamily: 'Montserrat-Bold',
            ),
          ),
          TextSpan(
            text: AppLocalizations.of(context)!.orHS,
          ),
          TextSpan(
            text: AppLocalizations.of(context)!.joinHS,
            style: const TextStyle(
              fontFamily: 'Montserrat-Bold',
            ),
          ),
          TextSpan(
            text: AppLocalizations.of(context)!.groupHS,
          ),
          TextSpan(
            text: AppLocalizations.of(context)!.challengeHS,
            style: const TextStyle(
              fontFamily: 'Montserrat-Bold',
            ),
          ),
        ],
      ),
    );
  }
}
