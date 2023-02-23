import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/individual_group/components/group_ended_participant_card.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

groupEndedDialog(BuildContext context) {
  showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      final group = Provider.of<IndividualGroupProvider>(context).group;
      final appLocalizations = AppLocalizations.of(context);
      String groupCurrencySymbol =
          NumberFormat.simpleCurrency(name: group?.groupCurrencyCode)
              .currencySymbol;
      if (group == null) return const SizedBox();
      return AlertDialog(
        title: StaticText(
          text: appLocalizations.groupEnded,
          textAlign: TextAlign.center,
          fontFamily: 'Montserrat-SemiBold',
          fontSize: TextSize.lBody,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              StaticText(
                text: appLocalizations.winnerWon(
                    groupCurrencySymbol, group.reward),
                fontSize: TextSize.mBody,
              ),
              ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) => const Divider(
                  indent: kDefaultPadding,
                  endIndent: kDefaultPadding,
                  height: 20,
                  thickness: 0.5,
                  color: kSecondaryColor,
                ),
                itemCount: group.participantsData.length,
                itemBuilder: (context, index) => GroupEndedParticipantCard(
                  participant: group.participantsData[index],
                ),
              ),
            ],
          ),
        ),
        contentPadding: const EdgeInsets.only(top: 20, bottom: 20),
        actionsAlignment: MainAxisAlignment.center,
        actionsPadding: const EdgeInsets.only(bottom: 15),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ButtonCommonStyle(
              onPressed: () {
                Provider.of<MixPanelProvider>(context, listen: false)
                    .logEvent(eventName: 'Group Ended Dialog OK');
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const StaticText(
                text: 'OK',
                fontSize: TextSize.mBody,
                fontFamily: 'Montserrat-SemiBold',
                color: kPrimaryColor,
              ),
            ),
          )
        ],
      );
    },
  );
}
