import 'package:flutter/material.dart';
import 'package:groupup/models/group_model.dart';
import 'package:groupup/screens/created_groups/components/app_bar.dart';
import 'package:groupup/screens/created_groups/components/body.dart';

class CreatedGroupsScreen extends StatelessWidget {
  CreatedGroupsScreen({super.key});

  final List<GroupModel> groups = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarCreatedGroups(),
      body: Column(
        children: [
          BodyCreatedGroup(
            groups: groups,
          ),
        ],
      ),
    );
  }
}
