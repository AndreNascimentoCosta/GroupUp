import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/models/dropdown.dart';
import 'package:groupup/models/individual_group.dart';
import 'package:groupup/screens/group/components/individual_group_card.dart';
import 'package:groupup/models/home_view.dart';

class BodyIndividualGroup extends StatelessWidget {
  BodyIndividualGroup({required this.homeViewModel,});

  final HomeViewModel homeViewModel;

  @override
  Widget build(BuildContext context) {
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
        itemCount: individualGroupData.length,
        itemBuilder: (context, index) => IndividualGroupCard(
          individualGroup: individualGroupData[index],
          homeViewModel: homeViewModel,
        ),
      ),
    );
  }
}
