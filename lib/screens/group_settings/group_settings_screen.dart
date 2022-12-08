import 'package:flutter/material.dart';
import 'package:groupup/models/home_view.dart';
import 'package:groupup/screens/group_settings/components/app_bar_group_settings.dart';
import 'package:groupup/screens/group_settings/components/body_settings.dart';

class GroupSettings extends StatefulWidget {
  const GroupSettings(
      {required this.homeViewModel,});

  final HomeViewModel homeViewModel;

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
      body: BodySettings(),
    );
  }
}
