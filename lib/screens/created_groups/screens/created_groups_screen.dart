import 'package:flutter/material.dart';
import 'package:groupup/models/group.dart';
import 'package:groupup/screens/created_groups/components/app_bar.dart';
import 'package:groupup/screens/created_groups/components/body.dart';

class CreatedGroupsScreen extends StatelessWidget {
  const CreatedGroupsScreen({required this.groupsData});

  final List<GroupModel> groupsData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCreatedGroups(),
      body: Column(
        children: [
          BodyCreatedGroup(groupsData: groupsData,),
        ],
      ),
    );
  }
}