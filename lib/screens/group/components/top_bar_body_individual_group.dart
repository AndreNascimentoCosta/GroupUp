import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/models/top_bar_individual_group.dart';
import 'package:groupup/screens/group/components/models/objective_reward.dart';
import 'package:groupup/screens/group/components/models/start_end.dart';
import 'package:groupup/screens/group/components/models/start_end_date.dart';
import 'package:groupup/styles/standard_text.dart';

class TopBarBodyIndividualGroup extends StatelessWidget {
  const TopBarBodyIndividualGroup({required this.topBarIndividualGroup});

  final TopBarIndividualGroupModel topBarIndividualGroup;

  @override
  Widget build(BuildContext context) {
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
            child: StandardTextStyle(
              text: 'RunForestRun',
              fontFamily: 'Montserrat-Bold',
              fontSize: 34,
            ),
          ),
          IntrinsicHeight(
            child: Row(
              children: [
                const SizedBox(
                  width: kDefaultPadding * 1.5,
                ),
                ObjectiveRewardModel(
                  topBarIndividualGroup: topBarIndividualGroup,
                  icon: topBarIndividualGroup.objectiveIcon,
                  text: topBarIndividualGroup.objective,
                ),
                const VerticalDivider(
                  width: kDefaultPadding * 2.25,
                  thickness: 1,
                  color: kSecondaryColor,
                ),
                ObjectiveRewardModel(
                  topBarIndividualGroup: topBarIndividualGroup,
                  icon: topBarIndividualGroup.rewardIcon,
                  text: topBarIndividualGroup.reward,
                ),
                const VerticalDivider(
                  width: kDefaultPadding * 2.25,
                  thickness: 1,
                  color: kSecondaryColor,
                ),
                StartEndModel(),
                const SizedBox(
                  width: kDefaultPadding / 1.5,
                ),
                StartEndDateModel(topBarIndividualGroup: topBarIndividualGroup,),
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
