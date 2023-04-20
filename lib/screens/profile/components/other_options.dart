import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/widgets/texts/large_body.dart';
import 'package:groupup/core/constants/design-system.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/screens/profile/components/alert_dialog_delete.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OtherOptionsProfile extends StatelessWidget {
  const OtherOptionsProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final appLocalizations = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding * 1.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ButtonCommonStyle(
            onPressed: () async {
              Provider.of<MixPanelProvider>(context, listen: false)
                  .logEvent(eventName: 'Report a Problem');
              final Uri emailLaunchUri = Uri(
                scheme: 'mailto',
                path: 'groupupapp@outlook.com',
              );
              launchUrl(emailLaunchUri);
            },
            child: LargeBody(
              text: appLocalizations.reportProblem,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: Insets.l * 1.5),
          ButtonCommonStyle(
            onPressed: () async {
              Provider.of<MixPanelProvider>(context, listen: false)
                  .logEvent(eventName: 'Privacy Policy');
              Navigator.pop(context);
              final url = Uri.parse('http://groupup.rf.gd/privacy-policy.html');
              if (await canLaunchUrl(url)) {
                await launchUrl(
                  url,
                  mode: LaunchMode.inAppWebView,
                );
              } else {
                throw 'Could not launch $url';
              }
            },
            child: LargeBody(
              text: appLocalizations.privacyPolicy,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: Insets.l * 1.5),
          ButtonCommonStyle(
            onPressed: () {
              Provider.of<MixPanelProvider>(context, listen: false)
                  .logEvent(eventName: 'Confirm Delete Account');
              Navigator.pop(context);
              confirmDelete(context);
            },
            child: LargeBody(
              text: appLocalizations.deleteAccount,
              textAlign: TextAlign.center,
              color: GPColors.black,
            ),
          ),
          const SizedBox(height: Insets.l * 1.5),
          ButtonCommonStyle(
            onPressed: () {
              Provider.of<MixPanelProvider>(context, listen: false)
                  .logEvent(eventName: 'Logout');
              Navigator.pop(context);
              authProvider.signOut(context);
            },
            child: LargeBody(
              text: appLocalizations.logout,
              textAlign: TextAlign.center,
              color: GPColors.red,
            ),
          ),
        ],
      ),
    );
  }
}
