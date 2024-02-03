import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/extensions/gp_navigator_extension.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';
import 'package:groupup/modules/individual_group/components/group_ended_participant_card.dart';
import 'package:groupup/modules/individual_group/components/individual_group_events.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

groupEndedDialog(BuildContext context) {
  showAdaptiveDialog(
    context: context,
    builder: (BuildContext context) {
      final appLocalizations = AppLocalizations.of(context)!;
      final individualGroupProvider =
          Provider.of<IndividualGroupProvider>(context);
      final group = individualGroupProvider.group;
      final currentUser = Provider.of<AuthProvider>(context).user;
      if (group == null) return const SizedBox();
      if (currentUser == null) return const SizedBox();
      final currentUserRank = group.participantsData.firstWhere(
        (element) {
          return element.uid == currentUser.id;
        },
      ).rank(group);
      final winner = group.participantsData
          .firstWhere((element) => element.uid == currentUser.id);
      return AlertDialog.adaptive(
        content: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: kDefaultPadding),
              child: GPTextBody(
                text: appLocalizations.winnerWon(group.reward),
                textAlign: TextAlign.center,
                maxLines: 3,
              ),
            ),
            GroupEndedParticipantCard(participant: winner),
          ],
        ),
        contentPadding: const EdgeInsets.only(top: 20, bottom: 20),
        actionsAlignment: MainAxisAlignment.center,
        actionsPadding: const EdgeInsets.only(bottom: 15),
        actions: [
          SizedBox(
            width: currentUserRank == appLocalizations.first
                ? context.screenWidth * 0.2
                : double.infinity,
            height: 40,
            child: ButtonCommonStyle(
              onPressed: () {
                Provider.of<MixPanelProvider>(context, listen: false).logEvent(
                  eventName:
                      IndividualGroupEvents.pressOkGroupEndedDialog.value,
                );
                context.pop();
                context.pop();
              },
              child: GPTextBody(
                text: appLocalizations.ok,
              ),
            ),
          ),
        ],
      );
    },
  );
}
