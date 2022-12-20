import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/models/group.dart';
import 'package:groupup/screens/groups/components/app_bar.dart';
import 'package:groupup/screens/groups/components/group_card.dart';
import 'package:groupup/models/home_view.dart';
import '../screens/groups_screen.dart';

class Body extends StatelessWidget {
  const Body({required this.homeViewModel});

  final HomeViewModel homeViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarGroup(
        homeViewModel: homeViewModel,
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
            groupModel: groupsData[index],
            press: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GroupsScreen(
                  homeViewModel: homeViewModel,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}