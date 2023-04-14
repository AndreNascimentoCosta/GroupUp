import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:rive/rive.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddDataAndPhotoOnboarding extends StatelessWidget {
  const AddDataAndPhotoOnboarding({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
      ),
      child: Column(
        children: [
          SizedBox(
            height: context.screenHeight * 0.475,
            width: context.screenHeight * 0.475,
            child: const RiveAnimation.asset(
              'assets/animations/add_data_and_photo_onboarding.riv',
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            height: context.screenHeight * 0.025,
          ),
          StaticText(
            text: appLocalizations.addDataAndPhotoOnboarding,
            fontSize: context.screenHeight * 0.0285,
            textAlign: TextAlign.center,
            fontFamily: 'MontSerrat-Bold',
          ),
          SizedBox(
            height: context.screenHeight * 0.025,
          ),
          SizedBox(
            width: 300,
            child: StaticText(
              text: appLocalizations.addDataAndPhotoOnboardingText,
              fontSize: context.screenHeight * 0.0215,
              maxLines: 3,
              textAlign: TextAlign.center,
              color: kSecondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
