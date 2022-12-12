import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/models/dropdown.dart';
import 'package:groupup/models/group.dart';
import 'package:groupup/screens/group/components/individual_group_card.dart';
import 'package:groupup/models/home_view.dart';

class BodyIndividualGroup extends StatelessWidget {
  BodyIndividualGroup({required this.homeViewModel, required this.groupModel});

  final HomeViewModel homeViewModel;
  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    final DropDownModel dropDownModel  = DropDownModel();

    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.only(
          top: kDefaultPadding / 2,
        ),
        separatorBuilder: (context, index) => const Divider(
          indent: kDefaultPadding,
          endIndent: kDefaultPadding,
          height: 20,
          thickness: 0.5,
          color: kSecondaryColor,
        ),
        itemCount: groupModel.individualGroup.length,
        itemBuilder: (context, index) => IndividualGroupCard(
          individualGroup: groupModel.individualGroup[index],
          homeViewModel: homeViewModel,
          meIndividualGroup: groupModel.meIndividualGroup,
        ),
      ),
    );
  }
}
