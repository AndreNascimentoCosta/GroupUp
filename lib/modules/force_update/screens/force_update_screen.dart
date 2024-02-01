import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/constants/url_launcher_constants.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/utils/icons/gp_icons.dart';
import 'package:groupup/core/utils/url_launcher/gp_url_launcher.dart';
import 'package:groupup/core/widgets/icons/gp_icon.dart';
import 'package:groupup/core/widgets/buttons/gp_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';
import 'package:groupup/core/widgets/texts/gp_text_header.dart';

class ForceUpdateScreen extends StatelessWidget {
  const ForceUpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: context.screenHeight * 0.05),
              GPTextHeader(
                text: appLocalizations.update + appLocalizations.groupUp,
                textAlign: TextAlign.center,
                fontSize: 30,
              ),
              SizedBox(height: context.screenHeight * 0.03),
              GPIcon(
                GPIcons.logoCircle,
                height: context.screenHeight * 0.15,
              ),
              const Spacer(),
              GPTextBody(
                text: appLocalizations.updateText,
                maxLines: 8,
                textAlign: TextAlign.center,
                fontFamily: 'Montserrat-Medium',
                fontSize: 22,
              ),
              SizedBox(height: context.screenHeight * 0.05),
              GPButton(
                text: appLocalizations.update,
                onPressed: () async {
                  await gpUrlLauncher.launch(
                    uri: UrlLauncherConstants.store(),
                  );
                },
              ),
              SizedBox(height: context.screenHeight * 0.025)
            ],
          ),
        ),
      ),
    );
  }
}
