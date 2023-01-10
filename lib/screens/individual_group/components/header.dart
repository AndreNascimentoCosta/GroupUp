import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:groupup/core/widgets/texts/title.dart';
import 'package:groupup/models/general_group_info.dart';
import 'package:groupup/models/show_group.dart';
import 'package:groupup/screens/individual_group/components/bottom_sheet.dart';
import 'package:groupup/screens/individual_group/components/date_bottom_sheet.dart';
import 'package:groupup/screens/individual_group/components/objective_reward.dart';
import 'package:groupup/screens/individual_group/components/start_end_date.dart';

class HeaderIndividualGroup extends StatelessWidget {
  const HeaderIndividualGroup({
    required this.generalGroupInfoModel,
    required this.showGroup,
  });

  final GeneralGroupInfoModel generalGroupInfoModel;
  final ShowGroupModel showGroup;

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
            child: GroupTitle(text: showGroup.projectName),
          ),
          IntrinsicHeight(
            child: Row(
              children: [
                SizedBox(width: MediaQuery.of(context).size.width * 0.075),
                ObjectiveRewardModel(
                  builder: BuilderBottomSheet(
                    height: 200,
                    child: HeaderBottomSheet(
                      generalGroupInfoModel: generalGroupInfoModel,
                      title: 'Objective',
                      hint: generalGroupInfoModel.objective,
                    ),
                  ),
                  generalGroupInfoModel: generalGroupInfoModel,
                  icon:
                      SvgPicture.asset('assets/icons/objective.svg').toString(),
                  text: generalGroupInfoModel.objective,
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
                      generalGroupInfoModel: generalGroupInfoModel,
                      title: 'Reward',
                      hint: generalGroupInfoModel.reward,
                    ),
                  ),
                  generalGroupInfoModel: generalGroupInfoModel,
                  icon: SvgPicture.asset('assets/icons/reward.svg').toString(),
                  text: generalGroupInfoModel.reward,
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
                      generalGroupInfoModel: generalGroupInfoModel,
                      title: 'Dates',
                    ),
                  ),
                  generalGroupInfoModel: generalGroupInfoModel,
                  showGroup: showGroup,
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
