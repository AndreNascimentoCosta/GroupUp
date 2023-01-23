import 'package:flutter/material.dart';
import 'package:groupup/models/group_model.dart';
import 'package:groupup/screens/individual_group_settings/edit_fields/edit_reward/components/app_bar_edit_group_reward.dart';
import 'package:groupup/screens/individual_group_settings/edit_fields/edit_reward/components/body_edit_group_reward.dart';
import 'package:groupup/core/providers/edit_group_reward_provider.dart';
import 'package:provider/provider.dart';

class EditGroupRewardScreen extends StatelessWidget {
  const EditGroupRewardScreen({required this.groups});

  final GroupModel groups;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EditGroupRewardProvider(groups.reward),
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          appBar: AppBarEditGroupReward(groups: groups),
          body: const SingleChildScrollView(
            child: EditGroupRewardBody(),
          ),
        ),
      ),
    );
  }
}