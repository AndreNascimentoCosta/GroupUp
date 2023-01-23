import 'package:flutter/material.dart';
import 'package:groupup/models/group_model.dart';
import 'package:groupup/screens/individual_group_settings/edit_fields/edit_objective/components/app_bar_edit_group_objective.dart';
import 'package:groupup/screens/individual_group_settings/edit_fields/edit_objective/components/body_edit_group_objective.dart';
import 'package:groupup/core/providers/edit_group_objective_provider.dart';
import 'package:provider/provider.dart';

class EditGroupObjectiveScreen extends StatelessWidget {
  const EditGroupObjectiveScreen({required this.groups});

  final GroupModel groups;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EditGroupObjectiveProvider(groups.objective),
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          appBar: AppBarEditGroupObjective(groups: groups),
          body: const SingleChildScrollView(
            child: EditGroupObjectiveBody(),
          ),
        ),
      ),
    );
  }
}