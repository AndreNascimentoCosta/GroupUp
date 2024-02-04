import 'package:flutter/material.dart';
import 'package:groupup/core/extensions/gp_navigator_extension.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/providers/edit_group_dates_provider.dart';
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
      create: (context) => EditGroupDatesProvider(),
      child: PopScope(
        canPop: false,
        child: Builder(
          builder: (context) {
            final editGroupDatesProvider =
                Provider.of<EditGroupDatesProvider>(context);
            return Scaffold(
              appBar: EditFieldsAppBar(
                headerText: appLocalizations.dates,
                onPressedLeftButton: () {
                  if (editGroupDatesProvider.newGroup.startDate == null) {
                    if (editGroupDatesProvider.newGroup.endDate == null) {
                      editGroupDatesProvider.clean();
                      Provider.of<MixPanelProvider>(context, listen: false)
                          .logEvent(
                        eventName: IndividualGroupSettingsEvents
                            .pressBackButtonEditGroupDates.value,
                      );
                      context.pop();
                    } else {
                      editGroupDatesProvider.confirmDiscard(context);
                    }
                  } else {
                    Provider.of<MixPanelProvider>(context, listen: false)
                        .logEvent(
                      eventName: IndividualGroupSettingsEvents
                          .pressDiscardAndBackButtonEditGroupDates.value,
                    );
                    editGroupDatesProvider.confirmDiscard(context);
                  }
                },
                onPressedRightButton: editGroupDatesProvider.done(
                  context,
                  group.startDate,
                  group.endDate,
                  group.id,
                ),
                colorRightButton: editGroupDatesProvider.done(context,
                            group.startDate, group.endDate, group.id) ==
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
