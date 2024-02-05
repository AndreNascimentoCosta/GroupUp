import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/constants/url_launcher_constants.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/constants/design_system.dart';
import 'package:groupup/core/utils/url_launcher/gp_url_launcher.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';
import 'package:groupup/modules/profile/components/alert_dialog_delete.dart';
import 'package:groupup/modules/profile/components/profile_events.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileOtherOptions extends StatelessWidget {
  const ProfileOtherOptions({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding * 1.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ButtonCommonStyle(
            onPressed: () async {
              Provider.of<MixPanelProvider>(context, listen: false).logEvent(
                eventName: ProfileEvents.reportProblem.value,
              );
              gpUrlLauncher.launch(
                uri: UrlLauncherConstants.emailAddress(
                  subject: appLocalizations.reportProblem,
                ),
              );
            },
            child: GPTextBody(
              text: appLocalizations.reportProblem,
              textAlign: TextAlign.center,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: Insets.l * 1.5),
          ButtonCommonStyle(
            onPressed: () async {
              Provider.of<MixPanelProvider>(context, listen: false).logEvent(
                eventName: ProfileEvents.pressPrivacyPolicyButton.value,
              );
              Navigator.pop(context);
              gpUrlLauncher.launch(
                uri: UrlLauncherConstants.privacyPolicy,
                mode: LaunchMode.inAppWebView,
              );
            },
            child: GPTextBody(
              text: appLocalizations.privacyPolicy,
              textAlign: TextAlign.center,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: Insets.l * 1.5),
          ButtonCommonStyle(
            onPressed: () {
              Provider.of<MixPanelProvider>(context, listen: false).logEvent(
                eventName: ProfileEvents.confirmDeleteAccount.value,
              );
              Navigator.pop(context);
              confirmDelete(context);
            },
            child: GPTextBody(
              text: appLocalizations.deleteAccount,
              textAlign: TextAlign.center,
              color: GPColors.black,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: Insets.l * 1.5),
          ButtonCommonStyle(
            onPressed: () {
              Provider.of<MixPanelProvider>(context, listen: false).logEvent(
                eventName: ProfileEvents.logout.value,
              );
              Navigator.pop(context);
              authProvider.signOut(context);
            },
            child: GPTextBody(
              text: appLocalizations.logout,
              textAlign: TextAlign.center,
              color: GPColors.red,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
