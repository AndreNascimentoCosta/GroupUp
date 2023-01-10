import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/models/group.dart';
import 'package:groupup/models/home_view.dart';
import 'package:groupup/models/participant.dart';
import 'package:groupup/models/show_group.dart';
import 'package:groupup/screens/add_input/models/calendar.dart';
import 'package:groupup/screens/add_input/models/add_input_group_button.dart';
import 'package:groupup/screens/add_input/models/data_history.dart';
import 'package:groupup/screens/individual_group/components/app_bar.dart';

class AddInputScreen extends StatefulWidget {
  const AddInputScreen({
    required this.groupModel,
    required this.homeViewModel,
    required this.participant,
    required this.showGroup,
  });

  final GroupModel groupModel;
  final HomeViewModel homeViewModel;
  final Participant participant;
  final ShowGroupModel showGroup;

  @override
  State<AddInputScreen> createState() => _AddInputScreenState();
}

class _AddInputScreenState extends State<AddInputScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarIndividualGroup(
        homeViewModel: widget.homeViewModel,
        groupModel: widget.groupModel,
        showGroup: widget.showGroup,
      ),
      body: Column(
        children: [
          Calendar(
            groupModel: widget.groupModel,
            participant: widget.participant,
          )
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          DataHistoryButton(
            homeViewModel: widget.homeViewModel,
            groupModel: widget.groupModel,
          ),
          const SizedBox(height: kDefaultPadding),
          AddInputGroupButton(
            homeViewModel: widget.homeViewModel,
            groupModel: widget.groupModel,
          ),
        ],
      ),
    );
  }
}
