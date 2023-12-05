import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/extensions/gp_navigator_extension.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/widgets/buttons/gp_button.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';
import 'package:groupup/core/widgets/texts/gp_text_header.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void confirmDelete(BuildContext context) {
  final authProvider = Provider.of<AuthProvider>(context, listen: false);
  final appLocalizations = AppLocalizations.of(context);
  showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: GPTextHeader(
          text: appLocalizations.confirm,
          textAlign: TextAlign.center,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: GPTextBody(
            text: appLocalizations.confirmDeleteAccount,
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        contentPadding: const EdgeInsets.only(top: 20, bottom: 20),
        actions: [
          GPButton(
            text: appLocalizations.yes,
            borderColor: GPColors.transparent,
            color: GPColors.transparent,
            onPressed: () => {
              Provider.of<MixPanelProvider>(context, listen: false)
                  .logEvent(eventName: 'Delete Account'),
              authProvider.signOut(context),
              context.pop(),
            },
            textColor: GPColors.primaryColor,
            height: 40,
            width: 140,
          ),
          GPButton(
            text: appLocalizations.no,
            textColor: GPColors.white,
            borderColor: GPColors.red,
            onPressed: () {
              Provider.of<MixPanelProvider>(context, listen: false)
                  .logEvent(eventName: 'Cancel Delete Account');
              context.pop();
            },
            color: GPColors.red,
            height: 40,
            width: 140,
          ),
        ],
      );
    },
  );
}
