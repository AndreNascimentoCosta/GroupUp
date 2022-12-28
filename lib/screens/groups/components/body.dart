import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/models/group.dart';
import 'package:groupup/screens/groups/components/app_bar.dart';
import 'package:groupup/screens/groups/components/group_card.dart';
import 'package:groupup/models/home_view.dart';
import 'package:groupup/screens/groups/components/no_group.dart';

class Body extends StatelessWidget {
  const Body({
    required this.homeViewModel,
    required this.groupsData,
  });

  final HomeViewModel homeViewModel;
  final List<GroupModel> groupsData;

  @override
  Widget build(BuildContext context) {
    if (groupsData.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarGroup(
          homeViewModel: homeViewModel,
          groupsData: groupsData,
        ),
        body: Scrollbar(
          child: Padding(
            padding: const EdgeInsets.only(top: kDefaultPadding / 2),
            child: Column(
              children: const [
                NoGroup(),
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarGroup(
          homeViewModel: homeViewModel,
          groupsData: groupsData,
        ),
        body: Scrollbar(
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
            itemBuilder: (context, index) => GroupsCard(
              homeViewModel: homeViewModel,
              participant: groupsData[index].meParticipant,
              groupModel: groupsData[index],
            ),
          ),
        ),
      );
    }
  }
}
