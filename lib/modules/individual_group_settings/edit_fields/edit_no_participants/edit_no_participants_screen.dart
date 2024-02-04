import 'package:flutter/material.dart';
import 'package:groupup/core/providers/edit_group_no_participants.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/modules/individual_group_settings/components/individual_group_settings_events.dart';
import 'package:groupup/modules/individual_group_settings/edit_fields/edit_fields_app_bar.dart';
import 'package:groupup/modules/individual_group_settings/edit_fields/edit_no_participants/components/edit_no_participants_body_.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
      child: PopScope(
        canPop: false,
        child: Builder(builder: (context) {
          final appLocalizations = AppLocalizations.of(context)!;
          final editGroupMaxParticipantsProvider =
              Provider.of<EditGroupNoParticipantsProvider>(context);
          return Scaffold(
            appBar: EditFieldsAppBar(
              headerText: appLocalizations.participants,
              onPressedLeftButton: () {
                if (editGroupMaxParticipantsProvider
                        .groupMaxParticipantsController.text ==
                    group.maxParticipants.toString()) {
                  Provider.of<MixPanelProvider>(context, listen: false)
                      .logEvent(
                    eventName: IndividualGroupSettingsEvents
                        .pressBackButtonEditNumberOfParticipants.value,
                  );
                  Navigator.pop(context);
                } else {
                  Provider.of<MixPanelProvider>(context, listen: false)
                      .logEvent(
                    eventName: IndividualGroupSettingsEvents
                        .pressDiscardAndBackButtonEditNumberOfParticipants
                        .value,
                  );
                  editGroupMaxParticipantsProvider.confirmDiscard(context);
                }
              },
              onPressedRightButton: editGroupMaxParticipantsProvider.done(
                context,
                group.maxParticipants.toString(),
                group.id,
                group.participants.length,
              ),
              colorRightButton: editGroupMaxParticipantsProvider.done(
                        context,
                        group.maxParticipants.toString(),
                        group.id,
                        group.participants.length,
                      ) ==
                      null
                  ? GPColors.secondaryColor
                  : GPColors.black,
            ),
            body: const SingleChildScrollView(
              child: EditGroupNoParticipantsBody(),
            ),
          );
        }),
      ),
    );
  }
}
