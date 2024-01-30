import 'package:flutter/material.dart';
import 'package:groupup/core/providers/edit_group_no_participants.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/modules/individual_group_settings/edit_fields/edit_no_participants/components/app_bar_edit_no_participants.dart';
import 'package:groupup/modules/individual_group_settings/edit_fields/edit_no_participants/components/body_bar_edit_no_participants.dart';

import 'package:provider/provider.dart';

class EditGroupNoParticipantsScreen extends StatelessWidget {
  const EditGroupNoParticipantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final group = Provider.of<IndividualGroupProvider>(context).group;
    if (group == null) {
      return const Scaffold();
    }
    return ChangeNotifierProvider(
      create: (context) => EditGroupNoParticipantsProvider(
        group.maxParticipants.toString(),
      ),
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: const Scaffold(
          appBar: AppBarEditGroupNoParticipats(),
          body: SingleChildScrollView(
            child: EditGroupNoParticipantsBody(),
          ),
        ),
      ),
    );
  }
}
