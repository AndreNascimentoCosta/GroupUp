import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:groupup/core/widgets/texts/title.dart';
import 'package:groupup/models/group_model.dart';
import 'package:groupup/screens/individual_group/components/bottom_sheet.dart';
import 'package:groupup/screens/individual_group/components/date_bottom_sheet.dart';
import 'package:groupup/screens/individual_group/components/objective_reward.dart';
import 'package:groupup/screens/individual_group/components/start_end_date.dart';

class HeaderIndividualGroup extends StatelessWidget {
  const HeaderIndividualGroup({
    required this.groups,
  });

  final GroupModel groups;

  @override
  Widget build(BuildContext context) {
    final objectiveController = TextEditingController(text: groups.objective);
    final rewardController = TextEditingController(text: groups.reward);
    return Container(
      color: Colors.white,
      height: 125,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: kDefaultPadding / 2.5,
              bottom: kDefaultPadding,
            ),
            child: GroupTitle(text: groups.projectName),
          ),
          IntrinsicHeight(
            child: Row(
              children: [
                SizedBox(width: MediaQuery.of(context).size.width * 0.075),
                ObjectiveRewardModel(
                  builder: BuilderBottomSheet(
                    height: 200,
                    child: HeaderBottomSheet(
                      controller: objectiveController,
                      title: 'Objective',
                      hint: groups.objective,
                    ),
                  ),
                  icon:
                      'assets/icons/objective.svg',
                  text: groups.objective,
                ),
                VerticalDivider(
                  width: MediaQuery.of(context).size.width * 0.115,
                  thickness: 1,
                  color: kSecondaryColor,
                ),
                ObjectiveRewardModel(
                  builder: BuilderBottomSheet(
                    height: 200,
                    child: HeaderBottomSheet(
                      controller: rewardController,
                      title: 'Reward',
                      hint: groups.reward,
                    ),
                  ),
                  icon: 'assets/icons/reward.svg',
                  text: groups.reward,
                ),
                const VerticalDivider(
                  width: kDefaultPadding * 2.25,
                  thickness: 1,
                  color: kSecondaryColor,
                ),
                StartEndDateButton(
                  builder: BuilderBottomSheet(
                    height: 250,
                    child: DateBottomSheet(
                      groups: groups,
                      title: 'Dates',
                    ),
                  ),
                  groups: groups,
                ),
                const SizedBox(
                  width: kDefaultPadding * 1.5,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
