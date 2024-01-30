import 'package:flutter/material.dart';
import 'package:groupup/core/providers/edit_group_reward_provider.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/modules/individual_group_settings/edit_fields/edit_reward/components/app_bar_edit_group_reward.dart';
import 'package:groupup/modules/individual_group_settings/edit_fields/edit_reward/components/body_edit_group_reward.dart';
import 'package:provider/provider.dart';

class EditGroupRewardScreen extends StatelessWidget {
  const EditGroupRewardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final group = Provider.of<IndividualGroupProvider>(context).group;
    if (group == null) {
      return const Scaffold();
    }
    return ChangeNotifierProvider(
      create: (context) => EditGroupRewardProvider(group.reward),
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: const Scaffold(
          appBar: AppBarEditGroupReward(),
          body: SingleChildScrollView(
            child: EditGroupRewardBody(),
          ),
        ),
      ),
    );
  }
}
