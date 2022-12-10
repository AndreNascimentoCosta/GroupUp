import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/models/group.dart';
import 'package:groupup/models/home_view.dart';
import 'package:groupup/screens/add_input/add_input_individual_group.dart';
import 'package:groupup/screens/group/components/app_bar_individual_group.dart';
import 'package:groupup/screens/group/components/top_bar_body_individual_group.dart';

class AddInputScreen extends StatefulWidget {
  const AddInputScreen({required this.groupModel, required this.homeViewModel});

  final GroupModel groupModel;
  final HomeViewModel homeViewModel;

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
      ),
      body: Column(
        children: [
          TopBarBodyIndividualGroup(
            topBarIndividualGroup: widget.groupModel.topBarIndividualGroupModel,
          ),
          const SizedBox(
            height: kDefaultPadding,
          ),
          Calendar(
            groupModel: widget.groupModel,
          )
        ],
      ),
    );
  }
}
