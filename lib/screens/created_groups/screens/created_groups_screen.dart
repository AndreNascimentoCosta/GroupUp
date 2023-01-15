import 'package:flutter/material.dart';
import 'package:groupup/models/show_group.dart';
import 'package:groupup/screens/created_groups/components/app_bar.dart';
import 'package:groupup/screens/created_groups/components/body.dart';

class CreatedGroupsScreen extends StatelessWidget {
  CreatedGroupsScreen({super.key});

  final List<ShowGroupModel> showGroup = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCreatedGroups(),
      body: Column(
        children: [
          BodyCreatedGroup(
            showGroup: showGroup,
          ),
        ],
      ),
    );
  }
}
