import 'package:flutter/material.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/modules/created_groups/components/created_groups_app_bar.dart';
import 'package:groupup/modules/created_groups/components/created_groups_body.dart';

class CreatedGroupsScreen extends StatelessWidget {
  const CreatedGroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: GPColors.white,
      appBar: AppBarCreatedGroups(),
      body: Column(
        children: [
          BodyCreatedGroup(),
        ],
      ),
    );
  }
}
