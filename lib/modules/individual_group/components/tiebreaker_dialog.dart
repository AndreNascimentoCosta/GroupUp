// ignore_for_file: use_build_context_synchronously
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/extensions/gp_navigator_extension.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/widgets/buttons/button_common_style.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';
import 'package:groupup/core/widgets/texts/gp_text_header.dart';
import 'package:groupup/modules/individual_group/components/individual_group_events.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

tiebreakerDialog(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? isFirstLoaded = prefs.getBool(keyIsFirstOpened);
  final appLocalizations = AppLocalizations.of(context)!;
  if (isFirstLoaded == null) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: GPTextHeader(
            text: appLocalizations.tieBreaker,
            textAlign: TextAlign.center,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: GPTextBody(
              text: appLocalizations.tieBreakerText,
              maxLines: 8,
              textAlign: TextAlign.center,
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
                      .logEvent(
                    eventName:
                        IndividualGroupEvents.pressOkTieBreakerDialog.value,
                  );
                  context.pop();
                  prefs.setBool(keyIsFirstOpened, false);
                },
                child: GPTextBody(
                  text: appLocalizations.ok,
                  color: GPColors.primaryColor,
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
