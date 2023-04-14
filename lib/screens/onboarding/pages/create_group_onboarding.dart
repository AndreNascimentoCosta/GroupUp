import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:rive/rive.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreateGroupOnboarding extends StatelessWidget {
  const CreateGroupOnboarding({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Column(
        children: [
          SizedBox(
            height: context.screenHeight * 0.475,
            width: context.screenHeight * 0.475,
            child: const RiveAnimation.asset(
              'assets/animations/create_group_onboarding.riv',
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: context.screenHeight * 0.025),
          StaticText(
            text: appLocalizations.createOrJoinAGroup,
            fontSize: context.screenHeight * 0.0285,
            fontFamily: 'MontSerrat-Bold',
          ),
          SizedBox(height: context.screenHeight * 0.025),
          SizedBox(
            width: 300,
            child: StaticText(
              text:
                  appLocalizations.createOrJoinAGroupOnboardingText,
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
