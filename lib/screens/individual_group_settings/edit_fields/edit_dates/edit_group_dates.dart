import 'package:flutter/material.dart';
import 'package:groupup/models/group_model.dart';
import 'package:groupup/screens/individual_group_settings/edit_fields/edit_dates/components/app_bar_edit_group_dates.dart';
import 'package:groupup/screens/individual_group_settings/edit_fields/edit_dates/components/body_edit_group_dates.dart';
import 'package:groupup/core/providers/edit_group_dates_provider.dart';
import 'package:provider/provider.dart';

class EditGroupDatesScreen extends StatelessWidget {
  const EditGroupDatesScreen({required this.groups});

  final GroupModel groups;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EditGroupDatesProvider(groups.projectName),
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          appBar: AppBarEditGroupDates(groups: groups),
          body: const SingleChildScrollView(
            child: EditGroupDatesBody(),
          ),
        ),
      ),
    );
  }
}