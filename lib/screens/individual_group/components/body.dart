import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/models/group.dart';
import 'package:groupup/screens/individual_group/components/individual_card.dart';
import 'package:groupup/models/home_view.dart';

class BodyIndividualGroup extends StatelessWidget {
  const BodyIndividualGroup({required this.homeViewModel, required this.groupModel});

  final HomeViewModel homeViewModel;
  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: Scrollbar(
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
          itemCount: groupModel.userInformation.length,
          itemBuilder: (context, index) => IndividualGroupCard(
            participant: groupModel.participant[index],
            homeViewModel: homeViewModel,
            meParticipant: groupModel.meParticipant,
          ),
        ),
      ),
    );
  }
}
