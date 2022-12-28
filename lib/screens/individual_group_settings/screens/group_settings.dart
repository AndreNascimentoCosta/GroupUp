import 'package:flutter/material.dart';
import 'package:groupup/models/group.dart';
import 'package:groupup/models/home_view.dart';
import 'package:groupup/screens/individual_group_settings/components/app_bar.dart';
import 'package:groupup/screens/individual_group_settings/components/body.dart';

class GroupSettings extends StatefulWidget {
  const GroupSettings({required this.homeViewModel, required this.groupModel});

  final HomeViewModel homeViewModel;
  final GroupModel groupModel;

  @override
  State<GroupSettings> createState() => _GroupSettingsState();
}

class _GroupSettingsState extends State<GroupSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarGroupSettings(
        homeViewModel: widget.homeViewModel,
      ),
      body: BodySettings(
        groupModel: widget.groupModel,
      ),
    );
  }
}
