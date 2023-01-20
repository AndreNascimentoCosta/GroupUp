import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/models/group_model.dart';
import 'package:groupup/screens/individual_group/components/floating_buttons/edit_group.dart';
import 'package:groupup/screens/individual_group/components/app_bar.dart';
import 'package:groupup/screens/individual_group/components/body.dart';
import 'package:groupup/screens/individual_group/components/header.dart';
import 'package:groupup/models/home_view.dart';

class IndividualGroupScreen extends StatelessWidget {
  IndividualGroupScreen({
    required this.homeViewModel,
  });

  final HomeViewModel homeViewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarIndividualGroup(
        homeViewModel: homeViewModel,
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          const HeaderIndividualGroup(),
          const SizedBox(height: kDefaultPadding),
          BodyIndividualGroup(
            homeViewModel: homeViewModel,
          )
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          EditGroupButton(
            homeViewModel: homeViewModel,
          ),
          const SizedBox(height: kDefaultPadding),
          // CalendarScreenButton(
          //   homeViewModel: widget.homeViewModel,
          //   groupModel: widget.groupModel,
          //   participant: widget.participant,
          //   groups: widget.groups,
          // ),
        ],
      ),
    );
  }
}
