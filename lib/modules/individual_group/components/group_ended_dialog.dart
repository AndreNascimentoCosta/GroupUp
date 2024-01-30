import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/extensions/gp_navigator_extension.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/widgets/loading/gp_loading.dart';
import 'package:groupup/modules/individual_group/components/group_ended_participant_card.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

groupEndedDialog(BuildContext context) {
  showAdaptiveDialog(
    context: context,
    builder: (BuildContext context) {
      final individualGroupProvider =
          Provider.of<IndividualGroupProvider>(context);
      final group = individualGroupProvider.group;
      final currentUser = Provider.of<AuthProvider>(context).user;
      final appLocalizations = AppLocalizations.of(context)!;
      bool isClaimingReward = false;
      if (currentUser == null) return const SizedBox();
      if (group == null) return const SizedBox();
      if (isClaimingReward == true) {
        return const GPLoading();
      }
      final currentUserRank = group.participantsData.firstWhere(
        (element) {
          return element.uid == currentUser.id;
        },
      ).rank(group);
      return AlertDialog.adaptive(
        title: Text(
          appLocalizations.groupEnded,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            fontFamily: 'Montserrat-SemiBold',
            color: GPColors.black,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: kDefaultPadding),
                child: Text(
                  appLocalizations.winnerWon(group.reward),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Montserrat-Medium',
                    color: GPColors.black,
                  ),
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                separatorBuilder: (context, index) => const Divider(
                  indent: kDefaultPadding,
                  endIndent: kDefaultPadding,
                  height: 20,
                  thickness: 0.5,
                  color: GPColors.secondaryColor,
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
            width: currentUserRank == '1º'
                ? context.screenWidth * 0.2
                : double.infinity,
            height: 40,
            child: ButtonCommonStyle(
              onPressed: () {
                Provider.of<MixPanelProvider>(context, listen: false)
                    .logEvent(eventName: 'Group Ended Dialog OK');
                context.pop();
                context.pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Montserrat-SemiBold',
                  color: GPColors.primaryColor,
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}

groupEndedDialog2(BuildContext context) {
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
      print(winner.name);
      return AlertDialog.adaptive(
        content: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: kDefaultPadding),
              child: Text(
                appLocalizations.winnerWon(group.reward),
                textAlign: TextAlign.center,
                maxLines: 3,
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'Montserrat-Medium',
                  color: GPColors.black,
                ),
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
            width: currentUserRank == '1º'
                ? context.screenWidth * 0.2
                : double.infinity,
            height: 40,
            child: ButtonCommonStyle(
              onPressed: () {
                Provider.of<MixPanelProvider>(context, listen: false)
                    .logEvent(eventName: 'Group Ended Dialog OK');
                context.pop();
                context.pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Montserrat-SemiBold',
                  color: GPColors.primaryColor,
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
