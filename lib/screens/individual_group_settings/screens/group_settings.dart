import 'package:flutter/material.dart';
import 'package:groupup/models/group_model.dart';
import 'package:groupup/models/home_view.dart';
import 'package:groupup/screens/individual_group_settings/components/app_bar.dart';
import 'package:groupup/screens/individual_group_settings/components/body.dart';

class GroupSettings extends StatelessWidget {
  const GroupSettings({
    required this.homeViewModel,
    required this.groups,
  });

  final HomeViewModel homeViewModel;
  final GroupModel groups;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarGroupSettings(
        homeViewModel: homeViewModel,
      ),
      body: BodySettings(
        groups: groups,
      ),
    );
  }
}
