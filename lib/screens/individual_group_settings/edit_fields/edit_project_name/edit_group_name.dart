import 'package:flutter/material.dart';
import 'package:groupup/models/group_model.dart';
import 'package:groupup/screens/individual_group_settings/edit_fields/edit_project_name/components/app_bar_edit_group_name.dart';
import 'package:groupup/screens/individual_group_settings/edit_fields/edit_project_name/components/body_edit_group_name.dart';
import 'package:groupup/screens/individual_group_settings/edit_fields/edit_project_name/edit_group_name_provider.dart';
import 'package:provider/provider.dart';

class EditGroupNameScreen extends StatelessWidget {
  const EditGroupNameScreen({required this.groups});

  final GroupModel groups;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EditGroupNameProvider(groups.projectName),
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          appBar: AppBarEditGroupName(groups: groups),
          body: const SingleChildScrollView(
            child: EditGroupNameBody(),
          ),
        ),
      ),
    );
  }
}