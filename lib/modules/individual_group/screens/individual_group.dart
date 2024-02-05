import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/constants/design_system.dart';
import 'package:groupup/modules/individual_group/components/floating_buttons/add_input_group_button.dart';
import 'package:groupup/modules/individual_group/components/calendar_add_input/calendar.dart';
import 'package:groupup/modules/individual_group/components/floating_buttons/calendar_screen_button.dart';
import 'package:groupup/modules/individual_group/components/individual_group_app_bar.dart';
import 'package:groupup/modules/individual_group/components/individual_group_body.dart';
import 'package:groupup/modules/individual_group/components/floating_buttons/edit_group.dart';
import 'package:groupup/modules/individual_group/components/floating_buttons/instagrammable_button.dart';
import 'package:groupup/modules/individual_group/components/group_ended_dialog.dart';
import 'package:groupup/modules/individual_group/components/individual_group_header.dart';
import 'package:groupup/models/home_view_model.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/modules/individual_group/components/tiebreaker_dialog.dart';
import 'package:provider/provider.dart';

enum FloatingButtonDetail {
  spacing,
  widget,
}

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

  @override
  void dispose() {
    Provider.of<IndividualGroupProvider>(context, listen: false)
        .removeListener(endGroupDialog);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final individualGroupProvider =
        Provider.of<IndividualGroupProvider>(context);
    if (individualGroupProvider.group == null) {
      return Scaffold(
        backgroundColor: GPColors.white,
        appBar: IndividualGroupAppBar(
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
                const IndividualGroupHeader(),
                const SizedBox(height: kDefaultPadding),
                IndividualGroupBody(
                  homeViewModel: homeViewModel,
                )
              ],
            ),
            const Column(
              children: [
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
    } else {
      final participantsSumValue =
          individualGroupProvider.group!.participantsData.map((element) {
        return element.sumData.value;
      }).toList();
      participantsSumValue.sort((a, b) => b.compareTo(a));
      return Scaffold(
        backgroundColor: GPColors.white,
        appBar: IndividualGroupAppBar(
          homeViewModel: homeViewModel,
        ),
        resizeToAvoidBottomInset: false,
        body: PageView(
          controller: individualGroupProvider.pageController,
          onPageChanged: (value) {
            individualGroupProvider.updateIndex(value);
          },
          children: [
            Column(
              children: [
                const IndividualGroupHeader(),
                const SizedBox(height: kDefaultPadding),
                IndividualGroupBody(
                  homeViewModel: homeViewModel,
                )
              ],
            ),
            const Column(
              children: [
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
                  getFloatingButton(context, FloatingButtonDetail.spacing),
                  getFloatingButton(context, FloatingButtonDetail.widget),
                ],
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget getFloatingButton(
      BuildContext context, FloatingButtonDetail detail) {
    final individualGroupProvider =
        Provider.of<IndividualGroupProvider>(context);
    final participantsSumValue =
        individualGroupProvider.group!.participantsData.map((element) {
      return element.sumData.value;
    }).toList();
    final dateTimeNow = DateTime.now();
    final dateTimeThreeDaysAgo = dateTimeNow.subtract(
      const Duration(
        days: 3,
      ),
    );
    final isGroupEnded = individualGroupProvider.group!.endDate!.isBefore(
      dateTimeNow,
    );
    final isGroupEndedMoreThanThreeDaysAgo =
        individualGroupProvider.group!.endDate!.isBefore(
      dateTimeThreeDaysAgo,
    );
    final isDateBetweenTodayAndThreeDaysAgo =
        isGroupEnded && isGroupEndedMoreThanThreeDaysAgo;
    final currentUser = Provider.of<AuthProvider>(context).user;
    if (currentUser == null) return const SizedBox();
    final currentUserSumValue = individualGroupProvider.group!.participantsData
        .firstWhere((element) => element.uid == currentUser.id)
        .sumData
        .value;
    if (isGroupEnded) return const SizedBox();
    if (isDateBetweenTodayAndThreeDaysAgo ||
        participantsSumValue.first == currentUserSumValue) {
      if (detail == FloatingButtonDetail.spacing) {
        return const SizedBox(height: kDefaultPadding);
      } else {
        if (individualGroupProvider.pageIndex == 0) {
          return CalendarScreenButton(
            homeViewModel: homeViewModel,
          );
        } else {
          return AddInputGroupButton(homeViewModel: homeViewModel);
        }
      }
    } else {
      return const SizedBox();
    }
  }

  void endGroupDialog() {
    if (!mounted) return;
    final group =
        Provider.of<IndividualGroupProvider>(context, listen: false).group;
    if (group == null) return;
    if (group.endDate == null) return;
    final participantsSumValue = group.participantsData.map((element) {
      return element.sumData.value;
    }).toList();
    participantsSumValue.sort((a, b) => b.compareTo(a));
    if (group.endDate!.isBefore(DateTime.now())) {
      if (participantsSumValue.length > 1 &&
          participantsSumValue
                  .where((element) => element == participantsSumValue.first)
                  .length >
              1) {
        if (group.endDate!.isBefore(
          DateTime.now().subtract(
            const Duration(
              days: 3,
            ),
          ),
        )) {
          if (willShowEndGroupDialog) return;
          willShowEndGroupDialog = true;
          WidgetsBinding.instance.addPostFrameCallback(
            (_) async {
              if (!mounted) return;
              return groupEndedDialog(context);
            },
          );
        } else {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) async {
              if (!mounted) return;
              return tiebreakerDialog(context);
            },
          );
        }
      } else {
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
              return groupEndedDialog(context);
            },
          );
        }
      }
    } else {
      return;
    }
  }
}
