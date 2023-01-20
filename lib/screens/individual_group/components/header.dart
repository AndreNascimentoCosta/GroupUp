import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/title.dart';
import 'package:groupup/screens/individual_group/components/individual_group_provider.dart';
import 'package:groupup/screens/individual_group/components/objective_reward.dart';
import 'package:groupup/screens/individual_group/components/start_end_date.dart';
import 'package:provider/provider.dart';

class HeaderIndividualGroup extends StatelessWidget {
  const HeaderIndividualGroup({super.key});

  @override
  Widget build(BuildContext context) {
    final group = Provider.of<IndividualGroupProvider>(context).group;
    if (group == null) {
      return const CircularProgressIndicator(color: kPrimaryColor);
    }
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
            child: SizedBox(
              width: 300,
              child: GroupTitle(
                text: group.projectName,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          IntrinsicHeight(
            child: Row(
              children: [
                SizedBox(width: MediaQuery.of(context).size.width * 0.075),
                ObjectiveRewardModel(
                  icon: 'assets/icons/objective.svg',
                  text: group.objective,
                ),
                VerticalDivider(
                  width: MediaQuery.of(context).size.width * 0.115,
                  thickness: 1,
                  color: kSecondaryColor,
                ),
                ObjectiveRewardModel(
                  icon: 'assets/icons/reward.svg',
                  text: group.reward,
                ),
                const VerticalDivider(
                  width: kDefaultPadding * 2.25,
                  thickness: 1,
                  color: kSecondaryColor,
                ),
                StartEndDateButton(groups: group),
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
