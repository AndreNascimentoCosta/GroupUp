import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/models/group.dart';
import 'package:groupup/screens/created_groups/components/individual_card.dart';

class BodyCreatedGroup extends StatelessWidget {
  const BodyCreatedGroup({required this.groupsData});

  final List<GroupModel> groupsData;

  @override
  Widget build(BuildContext context) {
    if (groupsData.isEmpty) {
      return const Expanded(
        child: Padding(
          padding: EdgeInsets.only(top: kDefaultPadding),
          child: Align(
            alignment: Alignment.topCenter,
            child: StaticText(
              text: 'No created groups',
              color: kSecondaryColor,
              textAlign: TextAlign.center,
              fontSize: 20,
            ),
          ),
        ),
      );
    } else {
      return Expanded(
        child: Scrollbar(
          child: ListView.separated(
            padding: const EdgeInsets.only(
              top: kDefaultPadding / 2,
            ),
            separatorBuilder: (context, index) => const Divider(
              indent: kDefaultPadding,
              endIndent: kDefaultPadding,
              height: kDefaultPadding,
              thickness: 0.5,
              color: kSecondaryColor,
            ),
            itemCount: groupsData.length,
            itemBuilder: (context, index) => IndividualCreatedGroup(
              groupModel: groupsData[index],
            ),
          ),
        ),
      );
    }
  }
}
