import 'package:flutter/material.dart';
import 'package:groupup/core/animations/rive_animations.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:groupup/screens/onboarding/components/standard_body_onboarding.dart';

class CreateGroupOnboarding extends StatelessWidget {
  const CreateGroupOnboarding({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
      ),
      child: StandardOnboardingBody(
        animation: RiveAnimations.createGroup,
        title: appLocalizations.createOrJoinAGroup,
        subtitle: appLocalizations.createOrJoinAGroupOnboardingText,
      ),
    );
  }
}
