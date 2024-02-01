import 'package:flutter/material.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/widgets/app_bar/gp_app_bar.dart';
import 'package:groupup/modules/created_groups/components/created_groups_body.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:groupup/modules/created_groups/components/created_groups_events.dart';
import 'package:groupup/modules/edit_profile/screens/edit_profile.dart';

class CreatedGroupsScreen extends StatelessWidget {
  const CreatedGroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: GPColors.white,
      appBar: GPAppBar(
        headerText: appLocalizations.createdGroups,
        eventName: CreatedGroupsEvents.pressBackButtonCreatedGroups.value,
        route: const EditProfileScreen(),
      ),
      body: const BodyCreatedGroup(),
    );
  }
}
