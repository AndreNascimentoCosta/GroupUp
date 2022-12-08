import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/models/dropdown.dart';
import 'package:groupup/models/group.dart';
import 'package:groupup/screens/groups/components/app_bar_groups.dart';
import 'package:groupup/screens/groups/components/groups_card.dart';
import 'package:groupup/models/home_view.dart';

import '../groups_screen.dart';

class Body extends StatelessWidget {
  Body({required this.homeViewModel, required this.dropDownModel});

  final HomeViewModel homeViewModel;
  final DropDownModel dropDownModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarGroup(
        homeViewModel: homeViewModel,
      ),
      body: ListView.separated(
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
          dropDownModel: dropDownModel,
          groupModel: groupsData[index],
          press: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GroupsScreen(
                homeViewModel: homeViewModel,
                dropDownModel: dropDownModel,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
