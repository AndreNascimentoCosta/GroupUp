import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/extensions/gp_navigator_extension.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';
import 'package:groupup/models/group_model.dart';
import 'package:groupup/core/providers/create_group_provider.dart';
import 'package:groupup/core/widgets/buttons/share_button.dart';
import 'package:groupup/modules/individual_group_settings/components/individual_group_settings_common_button.dart';
import 'package:groupup/modules/individual_group_settings/components/individual_group_settings_events.dart';
import 'package:groupup/core/widgets/buttons/button_common_style.dart';
import 'package:groupup/modules/report_participant/screens/report_participant_screen.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IndividualGroupSettingsBodyNotAdmin extends StatelessWidget {
  const IndividualGroupSettingsBodyNotAdmin({required this.groups});

  final GroupModel groups;

  @override
  Widget build(BuildContext context) {
    final createGroupProvider =
        Provider.of<CreateGroupProvider>(context, listen: false);
    final appLocalizations = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.only(
        top: kDefaultPadding,
        left: kDefaultPadding,
        right: kDefaultPadding,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ButtonCommonStyle(
              onPressed: () {
                Provider.of<MixPanelProvider>(context, listen: false).logEvent(
                  eventName: IndividualGroupSettingsEvents
                      .pressReportParticipantScreen.value,
                );
                context.push(
                  const ReportParticipantScreen(),
                );
              },
              child: IndividualGroupSettingCommonButton(
                name: appLocalizations.reportParticipant,
              ),
            ),
            SizedBox(
              height: context.isVerySmallScreen
                  ? context.screenHeight * 0.575
                  : context.isSmallScreen
                      ? context.screenHeight * 0.625
                      : context.screenHeight * 0.66,
            ),
            Row(
              children: [
                SizedBox(
                  width: 150,
                  child: GPTextBody(
                    text: appLocalizations.groupCode,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                ShareButton(
                  text: groups.groupCode,
                  onPressed: () async {
                    Provider.of<MixPanelProvider>(context, listen: false)
                        .logEvent(
                      eventName:
                          IndividualGroupSettingsEvents.shareGroupCode.value,
                    );
                    await Share.share(
                      appLocalizations.shareGroupCodeText(
                        groups.projectName,
                        groups.groupCode,
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: context.screenHeight * 0.05),
            ButtonCommonStyle(
              onPressed: () {
                Provider.of<MixPanelProvider>(context, listen: false).logEvent(
                  eventName: IndividualGroupSettingsEvents.pressExitGroup.value,
                );
                createGroupProvider.confirmExitGroup(
                  context,
                  groups.id,
                );
              },
              child: GPTextBody(
                text: appLocalizations.exitGroup,
                color: GPColors.red,
                fontSize: 16,
              ),
            ),
            SizedBox(height: context.screenHeight * 0.05),
          ],
        ),
      ),
    );
  }
}
