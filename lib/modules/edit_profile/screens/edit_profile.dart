import 'package:flutter/material.dart';
import 'package:groupup/core/widgets/app_bar/gp_app_bar.dart';
import 'package:groupup/modules/edit_profile/components/edit_profile_body.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:groupup/modules/edit_profile/components/edit_profile_events.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: GPAppBar(
        headerText: appLocalizations.editProfile,
        eventName: EditProfileEvents.pressBackButtonEditProfile.value,
        route: const EditProfileScreen(),
      ),
      body: const EditProfileBody(),
    );
  }
}
