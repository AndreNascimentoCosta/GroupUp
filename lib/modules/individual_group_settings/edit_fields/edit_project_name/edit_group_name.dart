import 'package:flutter/material.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/modules/individual_group_settings/edit_fields/edit_project_name/components/app_bar_edit_group_name.dart';
import 'package:groupup/modules/individual_group_settings/edit_fields/edit_project_name/components/body_edit_group_name.dart';
import 'package:groupup/core/providers/edit_group_name_provider.dart';
import 'package:provider/provider.dart';

class EditGroupNameScreen extends StatelessWidget {
  const EditGroupNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final group = Provider.of<IndividualGroupProvider>(context).group;
    if (group == null) {
      return const Scaffold();
    }
    return ChangeNotifierProvider(
      create: (context) => EditGroupNameProvider(group.projectName),
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: const Scaffold(
          appBar: AppBarEditGroupName(),
          body: SingleChildScrollView(
            child: EditGroupNameBody(),
          ),
        ),
      ),
    );
  }
}
