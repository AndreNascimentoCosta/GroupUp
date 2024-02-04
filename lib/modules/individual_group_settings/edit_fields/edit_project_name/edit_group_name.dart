import 'package:flutter/material.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/modules/individual_group_settings/components/individual_group_settings_events.dart';
import 'package:groupup/modules/individual_group_settings/edit_fields/edit_fields_app_bar.dart';
import 'package:groupup/modules/individual_group_settings/edit_fields/edit_project_name/components/edit_group_name_body.dart';
import 'package:groupup/core/providers/edit_group_name_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditGroupNameScreen extends StatelessWidget {
  const EditGroupNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final group = Provider.of<IndividualGroupProvider>(context).group;
    if (group == null) {
      return const Scaffold();
    }
    return ChangeNotifierProvider(
      create: (context) => EditGroupNameProvider(group.projectName),
      child: PopScope(
        canPop: false,
        child: Builder(builder: (context) {
          final appLocalizations = AppLocalizations.of(context)!;
          final editGroupNameProvider =
              Provider.of<EditGroupNameProvider>(context);
          return Scaffold(
            appBar: EditFieldsAppBar(
              headerText: appLocalizations.groupName,
              onPressedLeftButton: () {
                if (editGroupNameProvider.groupNameController.text ==
                    group.projectName) {
                  Provider.of<MixPanelProvider>(context, listen: false)
                      .logEvent(
                    eventName: IndividualGroupSettingsEvents
                        .pressBackButtonEditGroupName.value,
                  );
                  Navigator.pop(context);
                } else {
                  Provider.of<MixPanelProvider>(context, listen: false)
                      .logEvent(
                    eventName: IndividualGroupSettingsEvents
                        .pressDiscardChangesEditGroupName.value,
                  );
                  editGroupNameProvider.confirmDiscard(context);
                }
              },
              onPressedRightButton: editGroupNameProvider.done(
                  context, group.projectName, group.id),
              colorRightButton: editGroupNameProvider.done(
                          context, group.projectName, group.id) ==
                      null
                  ? GPColors.secondaryColor
                  : GPColors.black,
            ),
            body: const SingleChildScrollView(
              child: EditGroupNameBody(),
            ),
          );
        }),
      ),
    );
  }
}
