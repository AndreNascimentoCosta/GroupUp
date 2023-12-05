import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';
import 'package:groupup/core/widgets/texts/gp_text_header.dart';
import 'package:groupup/screens/individual_group/components/group_ended_participant_card.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

groupEndedDialog(BuildContext context) {
  showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      final individualGroupProvider =
          Provider.of<IndividualGroupProvider>(context);
      final group = individualGroupProvider.group;
      final currentUser = Provider.of<AuthProvider>(context).user;
      final appLocalizations = AppLocalizations.of(context);
      bool isClaimingReward = false;
      // String groupCurrencySymbol =
      //     NumberFormat.simpleCurrency(name: group?.groupCurrencyCode)
      //         .currencySymbol;
      if (currentUser == null) return const SizedBox();
      if (group == null) return const SizedBox();
      if (isClaimingReward == true) {
        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      }
      // final currentUserPaymentIntentIds = currentUser.paymentIntentIds;
      // final groupPaymentIntentIds = group.paymentIntentIds;
      final currentUserRank = group.participantsData.firstWhere(
        (element) {
          return element.uid == currentUser.id;
        },
      ).rank(group);
      return AlertDialog(
        title: GPTextHeader(
          text: appLocalizations.groupEnded,
          textAlign: TextAlign.center,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // if (double.parse(group.reward) == 0)
              //   const SizedBox()
              // else
              Padding(
                padding: const EdgeInsets.only(bottom: kDefaultPadding),
                child: GPTextBody(
                  text: appLocalizations.winnerWon(group.reward),
                  textAlign: TextAlign.center,
                  maxLines: 3,
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
          // if (individualGroupProvider.isClaimingReward == true)
          //   const Center(
          //     child: CircularProgressIndicator.adaptive(),
          //   )
          // else
          SizedBox(
            width: currentUserRank == '1º'
                ? context.screenWidth * 0.2
                : double.infinity,
            child: ButtonCommonStyle(
              onPressed: () {
                Provider.of<MixPanelProvider>(context, listen: false)
                    .logEvent(eventName: 'Group Ended Dialog OK');
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const GPTextBody(
                text: 'OK',
                fontFamily: 'Montserrat-SemiBold',
                color: GPColors.primaryColor,
              ),
            ),
          ),
          // if (individualGroupProvider.isClaimingReward == true)
          //   const Center(
          //     child: SizedBox(),
          //   )
          // else if (group.paymentIntentIds.isEmpty)
          //   const SizedBox()
          // else if (currentUserRank == '1º')
          //   SizedBox(
          //     width: context.screenWidth * 0.5,
          //     child: GPButton(
          //       onPressed: () async {
          //         late bool isAllClaimed;
          //         for (var i = 0; i < group.paymentIntentIds.length; i++) {
          //           if (currentUserPaymentIntentIds
          //                   .contains(groupPaymentIntentIds[i]) ==
          //               true) {
          //             isAllClaimed = true;
          //           } else {
          //             isAllClaimed = false;
          //             break;
          //           }
          //         }
          //         if (isAllClaimed == true) {
          //           Navigator.of(context).pop();
          //           Navigator.of(context).pop();
          //           ScaffoldMessenger.of(context).showSnackBar(
          //             SnackBar(
          //               content: Text(appLocalizations.rewardAlreadyClaimed),
          //               duration: const Duration(seconds: 2),
          //             ),
          //           );
          //           return;
          //         }
          //         await individualGroupProvider.claimReward(
          //           context,
          //           currentUser.id,
          //           group.id,
          //         );
          //         ScaffoldMessenger.of(context).showSnackBar(
          //           SnackBar(
          //             content: Text(appLocalizations.rewardClaimedText),
          //             duration: const Duration(seconds: 2),
          //           ),
          //         );
          //       },
          //       text: appLocalizations.claimReward,
          //       width: context.screenWidth * 0.4,
          //     ),
          //   )
          // else
          //   const SizedBox(),
        ],
      );
    },
  );
}
