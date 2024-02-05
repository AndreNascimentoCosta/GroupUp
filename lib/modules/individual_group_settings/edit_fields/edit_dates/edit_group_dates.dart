import 'package:flutter/material.dart';
import 'package:groupup/core/extensions/gp_navigator_extension.dart';
import 'package:groupup/core/providers/edit_group_fields_provider.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/modules/individual_group_settings/components/individual_group_settings_events.dart';
import 'package:groupup/modules/individual_group_settings/edit_fields/edit_dates/components/edit_group_dates_body.dart';
import 'package:groupup/modules/individual_group_settings/edit_fields/edit_fields_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditGroupDatesScreen extends StatelessWidget {
  const EditGroupDatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final group = Provider.of<IndividualGroupProvider>(context).group;

    if (group == null) {
      return const Scaffold();
    }
    return ChangeNotifierProvider(
      create: (context) => EditGroupFieldsProvider(),
      child: PopScope(
        canPop: false,
        child: Builder(
          builder: (context) {
            final editGroupFieldsProvider =
                Provider.of<EditGroupFieldsProvider>(context);
            return Scaffold(
              appBar: EditFieldsAppBar(
                headerText: appLocalizations.dates,
                onPressedLeftButton: () {
                  if (editGroupFieldsProvider.newGroup.startDate == null) {
                    if (editGroupFieldsProvider.newGroup.endDate == null) {
                      editGroupFieldsProvider.clean();
                      Provider.of<MixPanelProvider>(context, listen: false)
                          .logEvent(
                        eventName: IndividualGroupSettingsEvents
                            .pressBackButtonEditGroupDates.value,
                      );
                      context.pop();
                    } else {
                      editGroupFieldsProvider.confirmDiscard(
                        context,
                        IndividualGroupSettingsEvents
                            .pressDiscardChangesEditGroupDates.value,
                        IndividualGroupSettingsEvents
                            .keepChangesEditGroupDates.value,
                      );
                    }
                  } else {
                    Provider.of<MixPanelProvider>(context, listen: false)
                        .logEvent(
                      eventName: IndividualGroupSettingsEvents
                          .pressDiscardAndBackButtonEditGroupDates.value,
                    );
                    editGroupFieldsProvider.confirmDiscard(
                      context,
                      IndividualGroupSettingsEvents
                          .pressDiscardChangesEditGroupDates.value,
                      IndividualGroupSettingsEvents
                          .keepChangesEditGroupDates.value,
                    );
                  }
                },
                onPressedRightButton:
                    editGroupFieldsProvider.doneEditGroupDates(
                  context,
                  group.startDate,
                  group.endDate,
                  group.id,
                ),
                colorRightButton: editGroupFieldsProvider.doneEditGroupDates(
                            context,
                            group.startDate,
                            group.endDate,
                            group.id) ==
                        null
                    ? GPColors.secondaryColor
                    : GPColors.black,
              ),
              body: const SingleChildScrollView(
                child: EditGroupDatesBody(),
              ),
            );
          },
        ),
      ),
    );
  }
}
