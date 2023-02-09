import 'package:flutter/material.dart';
import 'package:groupup/core/providers/edit_group_no_participants.dart';
import 'package:groupup/models/group_model.dart';
import 'package:groupup/screens/individual_group_settings/edit_fields/edit_no_participants/components/app_bar_edit_no_participants.dart';
import 'package:groupup/screens/individual_group_settings/edit_fields/edit_no_participants/components/body_bar_edit_no_participants.dart';

import 'package:provider/provider.dart';

class EditGroupNoParticipantsScreen extends StatelessWidget {
  const EditGroupNoParticipantsScreen({required this.groups});

  final GroupModel groups;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EditGroupNoParticipantsProvider(
        groups.maxParticipants.toString(),
      ),
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          appBar: AppBarEditGroupNoParticipats(groups: groups),
          body: const SingleChildScrollView(
            child: EditGroupNoParticipantsBody(),
          ),
        ),
      ),
    );
  }
}