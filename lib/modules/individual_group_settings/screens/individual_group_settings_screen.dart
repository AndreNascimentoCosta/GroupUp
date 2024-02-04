import 'package:flutter/material.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/core/widgets/app_bar/gp_app_bar.dart';
import 'package:groupup/models/group_model.dart';
import 'package:groupup/models/home_view_model.dart';
import 'package:groupup/modules/individual_group_settings/components/individual_group_settings_body_admin.dart';
import 'package:groupup/modules/individual_group_settings/components/individual_group_settings_body_not_admin.dart';
import 'package:groupup/modules/individual_group_settings/components/individual_group_settings_events.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IndividualGroupSettingsScreen extends StatelessWidget {
  const IndividualGroupSettingsScreen({
    required this.homeViewModel,
    required this.groups,
  });

  final HomeViewModel homeViewModel;
  final GroupModel groups;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final individualGroupProvider = Provider.of<IndividualGroupProvider>(
      context,
      listen: false,
    );
    final currentUserId = Provider.of<AuthProvider>(context).user?.id;
    if (individualGroupProvider.group != null) {
      final currentUserData =
          individualGroupProvider.group!.participantsData.firstWhere(
        (element) => element.uid == currentUserId,
      );
      if (currentUserData.isAdmin) {
        return Scaffold(
          appBar: GPAppBar(
            headerText: appLocalizations.groupSettings,
            eventName: IndividualGroupSettingsEvents
                .pressBackButtonIndividualGroupSettings.value,
          ),
          body: const IndividualGroupSettingBodyAdmin(),
        );
      } else {
        return Scaffold(
          appBar: GPAppBar(
            headerText: appLocalizations.groupSettings,
            eventName: IndividualGroupSettingsEvents
                .pressBackButtonIndividualGroupSettings.value,
          ),
          body: IndividualGroupSettingsBodyNotAdmin(
            groups: groups,
          ),
        );
      }
    }
    return const Scaffold();
  }
}
