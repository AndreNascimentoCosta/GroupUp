import 'package:flutter/material.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/modules/individual_group_settings/edit_fields/edit_objective/components/app_bar_edit_group_objective.dart';
import 'package:groupup/modules/individual_group_settings/edit_fields/edit_objective/components/body_edit_group_objective.dart';
import 'package:groupup/core/providers/edit_group_objective_provider.dart';
import 'package:provider/provider.dart';

class EditGroupObjectiveScreen extends StatelessWidget {
  const EditGroupObjectiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final group = Provider.of<IndividualGroupProvider>(context).group;
    if (group == null) {
      return const Scaffold();
    }
    return ChangeNotifierProvider(
      create: (context) => EditGroupObjectiveProvider(group.objective),
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: const Scaffold(
          appBar: AppBarEditGroupObjective(),
          body: SingleChildScrollView(
            child: EditGroupObjectiveBody(),
          ),
        ),
      ),
    );
  }
}
