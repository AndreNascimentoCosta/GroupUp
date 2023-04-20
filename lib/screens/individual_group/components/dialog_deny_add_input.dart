import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/constants/design-system.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/texts/static_text.dart';

void denyAddInputDialog(BuildContext context, String bodyText) {
  final appLocalizations = AppLocalizations.of(context);
  showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: StaticText(
          text: appLocalizations.youCantDoThis,
          textAlign: TextAlign.center,
          fontFamily: 'Montserrat-SemiBold',
          fontSize: TextSize.lBody,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: StaticText(
            text: bodyText,
            maxLines: 5,
            textAlign: TextAlign.center,
            fontSize: TextSize.mBody,
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        contentPadding: const EdgeInsets.only(top: 20, bottom: 20),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ButtonCommonStyle(
              onPressed: () {
                Provider.of<MixPanelProvider>(context, listen: false)
                    .logEvent(eventName: 'Add Input');
                Navigator.of(context).pop();
              },
              child: const StaticText(
                text: 'OK',
                fontSize: TextSize.mBody,
                color: GPColors.primaryColor,
              ),
            ),
          )
        ],
      );
    },
  );
}
