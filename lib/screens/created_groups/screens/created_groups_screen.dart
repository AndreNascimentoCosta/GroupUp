import 'package:flutter/material.dart';
import 'package:groupup/screens/created_groups/components/created_groups_app_bar.dart';
import 'package:groupup/screens/created_groups/components/created_groups_body.dart';

class CreatedGroupsScreen extends StatelessWidget {
  const CreatedGroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarCreatedGroups(),
      body: Column(
        children: const [
          BodyCreatedGroup(),
        ],
      ),
    );
  }
}
