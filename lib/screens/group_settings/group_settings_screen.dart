import 'package:flutter/material.dart';
import 'package:groupup/screens/group_settings/components/app_bar_group_settings.dart';

class GroupSettings extends StatefulWidget {
  const GroupSettings({super.key});

  @override
  State<GroupSettings> createState() => _GroupSettingsState();
}

class _GroupSettingsState extends State<GroupSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarGroupSettings(),
    );
  }
}