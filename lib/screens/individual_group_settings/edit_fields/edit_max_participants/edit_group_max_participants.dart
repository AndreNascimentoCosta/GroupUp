import 'package:flutter/material.dart';
import 'package:groupup/models/group_model.dart';
import 'package:groupup/screens/individual_group_settings/edit_fields/edit_max_participants/components/app_bar_edit_group_max_participants.dart';
import 'package:groupup/screens/individual_group_settings/edit_fields/edit_max_participants/components/body_edit_group_max_participants.dart';
import 'package:groupup/core/providers/edit_group_max_participants_provider.dart';
import 'package:provider/provider.dart';

class EditGroupMaxParticipantsScreen extends StatelessWidget {
  const EditGroupMaxParticipantsScreen({required this.groups});

  final GroupModel groups;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EditGroupMaxParticipantsProvider(
        groups.maxParticipants.toString(),
      ),
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          appBar: AppBarEditGroupMaxParticipats(groups: groups),
          body: const SingleChildScrollView(
            child: EditGroupMaxParticipantsBody(),
          ),
        ),
      ),
    );
  }
}
