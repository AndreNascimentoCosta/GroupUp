import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/models/group.dart';
import 'package:groupup/screens/group/components/edit_group_button.dart';
import 'package:groupup/screens/group/components/app_bar_individual_group.dart';
import 'package:groupup/screens/group/components/body_individual_group.dart';
import 'package:groupup/screens/group/components/top_bar_body_individual_group.dart';
import 'package:groupup/screens/group/components/add_input_group_button.dart';
import 'package:groupup/screens/groups/components/home_view_model.dart';

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
      body: Column(
        children: [
          TopBarBodyIndividualGroup(
            topBarIndividualGroup: widget.groupModel.topBarIndividualGroupModel,
          ),
          const SizedBox(
            height: kDefaultPadding,
          ),
          BodyIndividualGroup(
            homeViewModel: widget.homeViewModel,
          )
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          EditGroupButton(homeViewModel: widget.homeViewModel,),
          const SizedBox(
            height: kDefaultPadding,
          ),
          AddInputGroupButton(homeViewModel: widget.homeViewModel,),
        ],
      ),
    );
  }
}
