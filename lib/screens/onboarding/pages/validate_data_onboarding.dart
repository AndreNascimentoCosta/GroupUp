import 'package:flutter/material.dart';
import 'package:groupup/animations/rive_animations.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/screens/onboarding/components/standard_body_onboarding.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ValidateDataOnboarding extends StatelessWidget {
  const ValidateDataOnboarding({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
      ),
      child: StandardOnboardingBody(
        animation: RiveAnimations.validateData,
        title: appLocalizations.validateDataOnboarding,
        subtitle: appLocalizations.validateDataOnboardingText,
      ),
    );
  }
}
