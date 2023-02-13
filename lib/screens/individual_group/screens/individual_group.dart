import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/individual_group/components/floating_buttons/add_input_group_button.dart';
import 'package:groupup/screens/individual_group/components/calendar_add_input/calendar.dart';
import 'package:groupup/screens/individual_group/components/floating_buttons/calenda_screen_button.dart';
import 'package:groupup/screens/individual_group/components/app_bar.dart';
import 'package:groupup/screens/individual_group/components/body.dart';
import 'package:groupup/screens/individual_group/components/floating_buttons/edit_group.dart';
import 'package:groupup/screens/individual_group/components/floating_buttons/instagrammable_button.dart';
import 'package:groupup/screens/individual_group/components/group_ended_participant_card.dart';
import 'package:groupup/screens/individual_group/components/header.dart';
import 'package:groupup/models/home_view.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IndividualGroupScreen extends StatefulWidget {
  const IndividualGroupScreen({super.key});

  @override
  State<IndividualGroupScreen> createState() => _IndividualGroupScreenState();
}

class _IndividualGroupScreenState extends State<IndividualGroupScreen> {
  var willShowEndGroupDialog = false;
  final homeViewModel = HomeViewModel();

  @override
  void initState() {
    super.initState();
    Provider.of<IndividualGroupProvider>(context, listen: false)
        .addListener(endGroupDialog);
  }

  void endGroupDialog() {
    if (!mounted) return;
    final group =
        Provider.of<IndividualGroupProvider>(context, listen: false).group;
    if (group == null) return;
    if (group.endDate == null) return;
    if (group.endDate!.isBefore(
      DateTime.now().subtract(
        const Duration(
          days: 1,
        ),
      ),
    )) {
      if (willShowEndGroupDialog) return;
      willShowEndGroupDialog = true;
      WidgetsBinding.instance.addPostFrameCallback(
        (_) async {
          if (!mounted) return;
          return showCupertinoDialog(
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
                        text: appLocalizations.winnerWon(groupCurrencySymbol, group.reward),
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
                        itemBuilder: (context, index) =>
                            GroupEndedParticipantCard(
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
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final individualGroupProvider =
        Provider.of<IndividualGroupProvider>(context);
    if (individualGroupProvider.group == null) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarIndividualGroup(
          homeViewModel: homeViewModel,
        ),
        body: PageView(
          controller: individualGroupProvider.pageController,
          onPageChanged: (value) {
            individualGroupProvider.updateIndex(value);
          },
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Column(
              children: [
                const HeaderIndividualGroup(),
                const SizedBox(height: kDefaultPadding),
                BodyIndividualGroup(
                  homeViewModel: homeViewModel,
                )
              ],
            ),
            Column(
              children: const [
                Calendar(),
              ],
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const InstagrammableButton(),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                EditAndHistoryGroupButton(
                  homeViewModel: homeViewModel,
                ),
                const SizedBox(height: kDefaultPadding),
                individualGroupProvider.pageIndex == 0
                    ? CalendarScreenButton(
                        homeViewModel: homeViewModel,
                      )
                    : AddInputGroupButton(homeViewModel: homeViewModel),
              ],
            ),
          ],
        ),
      );
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarIndividualGroup(
        homeViewModel: homeViewModel,
      ),
      resizeToAvoidBottomInset: false,
      body: PageView(
        controller: individualGroupProvider.pageController,
        onPageChanged: (value) {
          individualGroupProvider.updateIndex(value);
        },
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Column(
            children: [
              const HeaderIndividualGroup(),
              const SizedBox(height: kDefaultPadding),
              BodyIndividualGroup(
                homeViewModel: homeViewModel,
              )
            ],
          ),
          Column(
            children: const [
              Calendar(),
            ],
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: Insets.m,
          horizontal: Insets.l,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const InstagrammableButton(),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                EditAndHistoryGroupButton(
                  homeViewModel: homeViewModel,
                ),
                if (individualGroupProvider.group == null) const SizedBox(),
                if (individualGroupProvider.group?.endDate == null)
                  const SizedBox(),
                individualGroupProvider.group!.endDate!
                            .isBefore(DateTime.now()) &&
                        individualGroupProvider.group!.endDate!.isAfter(
                            DateTime.now().subtract(const Duration(days: 1)))
                    ? const SizedBox()
                    : const SizedBox(height: kDefaultPadding),
                if (individualGroupProvider.group == null) const SizedBox(),
                if (individualGroupProvider.group?.endDate == null)
                  const SizedBox(),
                individualGroupProvider.group!.endDate!
                            .isBefore(DateTime.now()) &&
                        individualGroupProvider.group!.endDate!.isAfter(
                            DateTime.now().subtract(const Duration(days: 1)))
                    ? const SizedBox()
                    : individualGroupProvider.pageIndex == 0
                        ? CalendarScreenButton(
                            homeViewModel: homeViewModel,
                          )
                        : AddInputGroupButton(homeViewModel: homeViewModel),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
