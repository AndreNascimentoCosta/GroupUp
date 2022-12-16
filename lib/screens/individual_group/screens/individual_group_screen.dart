import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/models/group.dart';
import 'package:groupup/screens/individual_group/components/floating_buttons/edit_group_button.dart';
import 'package:groupup/screens/individual_group/components/app_bar_individual_group.dart';
import 'package:groupup/screens/individual_group/components/body_individual_group.dart';
import 'package:groupup/screens/individual_group/components/top_bar_body_individual_group.dart';
import 'package:groupup/screens/individual_group/components/floating_buttons/add_input_group_button.dart';
import 'package:groupup/models/home_view.dart';

class IndividualGroupScreen extends StatefulWidget {
  const IndividualGroupScreen({
    required this.homeViewModel,
    required this.groupModel,
  });

  final HomeViewModel homeViewModel;
  final GroupModel groupModel;

  @override
  State<IndividualGroupScreen> createState() => _IndividualGroupScreenState();
}

class _IndividualGroupScreenState extends State<IndividualGroupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarIndividualGroup(
        homeViewModel: widget.homeViewModel,
        groupModel: widget.groupModel,
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          TopBarBodyIndividualGroup(
            generalGroupInfoModel: widget.groupModel.generalGroupInfoModel,
          ),
          const SizedBox(height: kDefaultPadding),
          BodyIndividualGroup(
            homeViewModel: widget.homeViewModel,
            groupModel: widget.groupModel,
          )
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          EditGroupButton(
            homeViewModel: widget.homeViewModel,
          ),
          const SizedBox(height: kDefaultPadding),
          CalendarScreenButton(
            homeViewModel: widget.homeViewModel,
            groupModel: widget.groupModel,
          ),
        ],
      ),
    );
  }
}
