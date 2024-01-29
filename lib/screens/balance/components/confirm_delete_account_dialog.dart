// ignore_for_file: use_build_context_synchronously
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/providers/stripe_payment_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/widgets/buttons/gp_button.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';
import 'package:groupup/core/widgets/texts/gp_text_header.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/providers/mix_panel_provider.dart';

void confirmDeleteAccountDialog(BuildContext rootContext) {
  final authProvider = Provider.of<AuthProvider>(rootContext, listen: false);
  final appLocalizations = AppLocalizations.of(rootContext)!;
  showCupertinoDialog(
    context: rootContext,
    builder: (BuildContext newContext) {
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
            text: appLocalizations.deleteConnectedAccountText,
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        contentPadding: const EdgeInsets.only(top: 20, bottom: 20),
        actions: [
          GPButton(
            text: appLocalizations.no,
            textColor: GPColors.red,
            borderColor: GPColors.transparent,
            onPressed: () {
              Provider.of<MixPanelProvider>(newContext, listen: false)
                  .logEvent(eventName: 'Cancel Delete Connected Account');
              Navigator.of(newContext).pop();
            },
            color: GPColors.transparent,
            height: 40,
            width: 140,
          ),
          GPButton(
            text: appLocalizations.yes,
            borderColor: GPColors.primaryColor,
            onPressed: () async {
              Provider.of<MixPanelProvider>(newContext, listen: false)
                  .logEvent(eventName: 'Delete Connected Account');
              await Provider.of<StripePaymentProvider>(newContext,
                      listen: false)
                  .deleteConnectedAccount(
                newContext,
                authProvider.user!.stripeAccountId,
              );
              await authProvider.getUser();
              Navigator.of(newContext).pop();
              ScaffoldMessenger.of(rootContext).showSnackBar(
                SnackBar(
                  content: Text(appLocalizations.connectedAccountDeleted),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            height: 40,
            width: 140,
          ),
        ],
      );
    },
  );
}
