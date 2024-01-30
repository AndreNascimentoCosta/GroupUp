import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/utils/icons/gp_icons.dart';
import 'package:groupup/core/widgets/icons/gp_icon.dart';
import 'package:groupup/core/widgets/buttons/gp_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';
import 'package:groupup/core/widgets/texts/gp_text_header.dart';
import 'package:url_launcher/url_launcher.dart';

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
                  final url = store();
                  if (await canLaunchUrl(url)) {
                    await launchUrl(
                      url,
                      mode: LaunchMode.externalApplication,
                    );
                  } else {
                    throw 'Could not launch $url';
                  }
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

Uri store() {
  switch (defaultTargetPlatform) {
    case TargetPlatform.android:
      return Uri(
        scheme: 'https',
        host: 'play.google.com',
        path: 'store/apps/details',
        queryParameters: {
          'id': 'com.andrecosta.groupup',
        },
      );
    case TargetPlatform.iOS:
      return Uri(
        scheme: 'https',
        host: 'apps.apple.com',
        path: 'app/groupup-get-it-now/id1667979922',
      );
    default:
      throw UnsupportedError('Platform not supported');
  }
}
