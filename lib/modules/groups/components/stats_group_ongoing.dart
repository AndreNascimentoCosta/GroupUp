import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/utils/icons/gp_icons.dart';
import 'package:groupup/core/widgets/icons/gp_icon.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';
import 'package:groupup/core/constants/design-system.dart';
import 'package:groupup/models/group_model.dart';
import 'package:groupup/models/home_view.dart';
import 'package:provider/provider.dart';

enum StatsType {
  daysGone,
  daysLeft,
}

class StatsGroup extends StatelessWidget {
  const StatsGroup({
    Key? key,
    required this.group,
    required this.homeViewModel,
  }) : super(key: key);

  final GroupModel group;
  final HomeViewModel homeViewModel;

  @override
  Widget build(BuildContext context) {
    final currentUserId = Provider.of<AuthProvider>(context).user?.id;
    final currentUserRank =
        group.currentParticipant(currentUserId ?? '').rank(group);
    return ValueListenableBuilder(
      valueListenable: homeViewModel.isEditing,
      builder: (context, value, child) {
        return AnimatedContainer(
          width: !value ? 80 : 0,
          duration: const Duration(milliseconds: 50),
          child: Visibility(
            visible: !value,
            child: Row(
              children: [
                const Flexible(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: kDefaultPadding,
                    ),
                    child: Column(
                      children: [
                        GPIcon(
                          GPIcons.rank,
                          color: GPColors.black,
                          height: Insets.l,
                          width: Insets.l,
                        ),
                        SizedBox(
                          height: kDefaultPadding * 0.25,
                        ),
                        GPIcon(
                          GPIcons.daysGone,
                          color: GPColors.black,
                          height: Insets.l,
                          width: Insets.l,
                        ),
                        SizedBox(
                          height: kDefaultPadding * 0.25,
                        ),
                        GPIcon(
                          GPIcons.daysLeft,
                          color: GPColors.black,
                          height: Insets.l,
                          width: Insets.l,
                        ),
                      ],
                    ),
                  ),
                ),
                if (group.endDate != null)
                  SizedBox(
                    width: Insets.l,
                    child: Column(
                      children: [
                        GPTextBody(
                          text: currentUserRank,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: kDefaultPadding * 0.25,
                        ),
                        GPTextBody(
                          text: getStatsText(
                            group,
                            StatsType.daysGone,
                          ),
                          textAlign: TextAlign.center,
                          color: GPColors.red,
                        ),
                        const SizedBox(
                          height: kDefaultPadding * 0.25,
                        ),
                        GPTextBody(
                          text: getStatsText(
                            group,
                            StatsType.daysLeft,
                          ),
                          textAlign: TextAlign.center,
                          color: GPColors.primaryColor,
                        ),
                      ],
                    ),
                  )
              ],
            ),
          ),
        );
      },
    );
  }
}

String getStatsText(GroupModel group, StatsType statsType) {
  final participantsSumValue = group.participantsData.map((element) {
    return element.sumData.value;
  }).toList();
  final groupExpired = group.endDate!.isBefore(DateTime.now());
  final groupNotPlayed = participantsSumValue.length <= 1;
  final groupTied = participantsSumValue
          .where((element) => element == participantsSumValue.first)
          .length <=
      1;
  if (groupExpired && groupNotPlayed && groupTied) {
    return '-';
  }
  switch (statsType) {
    case StatsType.daysGone:
      return group.daysGone;
    case StatsType.daysLeft:
      return group.daysLeft;
  }
}
