import 'package:flutter/material.dart';
import 'package:groupup/core/providers/edit_group_fields_provider.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/modules/individual_group_settings/components/individual_group_settings_events.dart';
import 'package:groupup/modules/individual_group_settings/edit_fields/edit_fields_app_bar.dart';
import 'package:groupup/modules/individual_group_settings/edit_fields/edit_objective/components/edit_group_objective_body.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditGroupObjectiveScreen extends StatelessWidget {
  const EditGroupObjectiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final group = Provider.of<IndividualGroupProvider>(context).group;
    if (group == null) {
      return const Scaffold();
    }
    return ChangeNotifierProvider(
      create: (context) =>
          EditGroupFieldsProvider.groupObjective(group.objective),
      child: PopScope(
        canPop: false,
        child: Builder(builder: (context) {
          final appLocalizations = AppLocalizations.of(context)!;
          final editGroupFieldsProvider =
              Provider.of<EditGroupFieldsProvider>(context);
          return Scaffold(
            appBar: EditFieldsAppBar(
              headerText: appLocalizations.groupObjective,
              onPressedLeftButton: () {
                if (editGroupFieldsProvider.groupObjectiveController.text ==
                    group.objective) {
                  Provider.of<MixPanelProvider>(context, listen: false)
                      .logEvent(
                    eventName: IndividualGroupSettingsEvents
                        .pressBackButtonEditGroupObjective.value,
                  );
                  Navigator.pop(context);
                } else {
                  Provider.of<MixPanelProvider>(context, listen: false)
                      .logEvent(
                    eventName: IndividualGroupSettingsEvents
                        .pressDiscardChangesEditGroupObjective.value,
                  );
                  editGroupFieldsProvider.confirmDiscard(
                    context,
                    IndividualGroupSettingsEvents.pressEditGroupObjetive.value,
                    IndividualGroupSettingsEvents
                        .keepChangesEditGroupObjective.value,
                  );
                }
              },
              onPressedRightButton: editGroupFieldsProvider
                  .doneEditGroupObjective(context, group.objective, group.id),
              colorRightButton: editGroupFieldsProvider.doneEditGroupObjective(
                          context, group.objective, group.id) ==
                      null
                  ? GPColors.secondaryColor
                  : GPColors.black,
            ),
            body: const SingleChildScrollView(
              child: EditGroupObjectiveBody(),
            ),
          );
        }),
      ),
    );
  }
}
