import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/models/group.dart';
import 'package:groupup/screens/balance/components/individual_card.dart';

class GroupsBalance extends StatelessWidget {
  const GroupsBalance({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Scrollbar(
          child: ListView.separated(
            padding: const EdgeInsets.only(
              top: kDefaultPadding / 2,
            ),
            separatorBuilder: (context, index) => const Padding(
              padding: EdgeInsets.only(top: kDefaultPadding),
            ),
            itemCount: groupsData.length,
            itemBuilder: (context, index) {
              return IndividualCardBalance(
              groupModel: groupsData[index],
            );
            },
          ),
        ),
      ),
    );
  }
}
