import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/models/general_group_info.dart';
import 'package:groupup/screens/group/components/alert_dialog.dart';
import 'package:groupup/screens/group/components/date_alert_dialog.dart';
import 'package:groupup/screens/group/models/objective_reward.dart';
import 'package:groupup/screens/group/models/start_end_date.dart';
import 'package:groupup/styles/text.dart';

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
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: ((context) {
                        return AlertDialogModel(
                          generalGroupInfoModel: generalGroupInfoModel,
                          title: 'Objective',
                          hint: generalGroupInfoModel.objective,
                        );
                      }),
                    );
                  },
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
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: ((context) {
                          return AlertDialogModel(
                            generalGroupInfoModel: generalGroupInfoModel,
                            title: 'Reward',
                            hint: generalGroupInfoModel.reward,
                          );
                        }));
                  },
                  generalGroupInfoModel: generalGroupInfoModel,
                  icon: generalGroupInfoModel.rewardIcon,
                  text: generalGroupInfoModel.reward,
                ),
                const VerticalDivider(
                  width: kDefaultPadding * 2.25,
                  thickness: 1,
                  color: kSecondaryColor,
                ),
                StartEndDateModel(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: ((context) {
                          return DateAlertDialogModel(
                            generalGroupInfoModel: generalGroupInfoModel,
                            title: 'Date',
                          );
                        }));
                  },
                  generalGroupInfoModel: generalGroupInfoModel,
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
