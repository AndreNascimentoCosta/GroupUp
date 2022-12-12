import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/models/general_group_info.dart';
import 'package:groupup/screens/group/models/objective_reward.dart';
import 'package:groupup/screens/group/models/start_end.dart';
import 'package:groupup/screens/group/models/start_end_date.dart';
import 'package:groupup/styles/standard_text.dart';

class TopBarBodyIndividualGroup extends StatelessWidget {
  const TopBarBodyIndividualGroup({required this.generalGroupInfoModel});

  final GeneralGroupInfoModel generalGroupInfoModel;

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
              text: generalGroupInfoModel.title,
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
                  generalGroupInfoModel: generalGroupInfoModel,
                  icon: generalGroupInfoModel.objectiveIcon,
                  text: generalGroupInfoModel.objective,
                ),
                const VerticalDivider(
                  width: kDefaultPadding * 2.25,
                  thickness: 1,
                  color: kSecondaryColor,
                ),
                ObjectiveRewardModel(
                  generalGroupInfoModel: generalGroupInfoModel,
                  icon: generalGroupInfoModel.rewardIcon,
                  text: generalGroupInfoModel.reward,
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
                StartEndDateModel(generalGroupInfoModel: generalGroupInfoModel,),
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
