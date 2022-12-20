import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/general_group_info.dart';
import 'package:groupup/screens/individual_group/components/bottom_sheet.dart';
import 'package:groupup/screens/individual_group/components/date_bottom_sheet.dart';
import 'package:groupup/screens/individual_group/models/objective_reward.dart';
import 'package:groupup/screens/individual_group/models/start_end_date.dart';
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
                    showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(Insets.m),
                        ),
                        builder: (context) {
                          return Padding(
                            padding: MediaQuery.of(context).viewInsets,
                            child: Wrap(
                              children: <Widget>[
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: 200,
                                      child: TopBarBottomSheet(
                                        generalGroupInfoModel:
                                            generalGroupInfoModel,
                                        title: 'Objective',
                                        hint: generalGroupInfoModel.objective,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        });
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
                    showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(Insets.m),
                        ),
                        builder: (context) {
                          return Padding(
                            padding: MediaQuery.of(context).viewInsets,
                            child: Wrap(
                              children: <Widget>[
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: 200,
                                      child: TopBarBottomSheet(
                                        generalGroupInfoModel:
                                            generalGroupInfoModel,
                                        title: 'Reward',
                                        hint: generalGroupInfoModel.reward,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        });
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
                    showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(Insets.m),
                        ),
                        builder: (context) {
                          return Padding(
                            padding: MediaQuery.of(context).viewInsets,
                            child: Wrap(
                              children: <Widget>[
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: 250,
                                      child: DateBottomSheet(
                                        generalGroupInfoModel:
                                            generalGroupInfoModel,
                                        title: 'Dates',
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        });
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
