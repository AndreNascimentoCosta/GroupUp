import 'package:flutter/material.dart';
import 'package:groupup/core/providers/edit_group_fields_provider.dart';
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
      create: (context) => EditGroupFieldsProvider.groupMaxParticipants(
        group.maxParticipants.toString(),
      ),
      child: PopScope(
        canPop: false,
        child: Builder(builder: (context) {
          final appLocalizations = AppLocalizations.of(context)!;
          final editGroupFieldsProvider =
              Provider.of<EditGroupFieldsProvider>(context);
          return Scaffold(
            appBar: EditFieldsAppBar(
              headerText: appLocalizations.participants,
              onPressedLeftButton: () {
                if (editGroupFieldsProvider
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
                  editGroupFieldsProvider.confirmDiscard(
                    context,
                    IndividualGroupSettingsEvents
                        .pressEditNumberOfParticipants.value,
                    IndividualGroupSettingsEvents
                        .keepChangesEditNumberOfParticipants.value,
                  );
                }
              },
              onPressedRightButton:
                  editGroupFieldsProvider.doneEditNoParticipants(
                context,
                group.maxParticipants.toString(),
                group.id,
                group.participants.length,
              ),
              colorRightButton: editGroupFieldsProvider.doneEditNoParticipants(
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
