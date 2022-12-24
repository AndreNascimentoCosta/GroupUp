import 'package:flutter/material.dart';
import 'package:groupup/screens/created_groups/components/app_bar.dart';
import 'package:groupup/screens/created_groups/components/body.dart';

class CreatedGroupsScreen extends StatelessWidget {
  const CreatedGroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarCreatedGroups(),
      body: BodyCreatedGroup(),
    );
  }
}