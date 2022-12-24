import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/models/group.dart';
import 'package:groupup/screens/created_groups/components/individual_card.dart';

class BodyCreatedGroup extends StatelessWidget {
  const BodyCreatedGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
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
    );
  }
}
