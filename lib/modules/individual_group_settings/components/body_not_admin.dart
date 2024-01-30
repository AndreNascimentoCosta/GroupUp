import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';
import 'package:groupup/models/group_model.dart';
import 'package:groupup/core/providers/create_group_provider.dart';
import 'package:groupup/core/widgets/buttons/share_button.dart';
import 'package:groupup/modules/individual_group_settings/components/body_content_arrow.dart';
import 'package:groupup/modules/individual_group_settings/components/other_options.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../report_participant/screens/report_participant.dart';

class BodyNotAdminSettings extends StatelessWidget {
  const BodyNotAdminSettings({required this.groups});

  final GroupModel groups;

  @override
  Widget build(BuildContext context) {
    final createGroupProvider =
        Provider.of<CreateGroupProvider>(context, listen: false);
    final appLocalizations = AppLocalizations.of(context)!;
    final screenHeight = context.screenHeight;
    final screenWidth = context.screenWidth;
    final isSmallScreen = screenHeight < 800 || screenWidth < 350;
    final isVerySmallScreen = screenHeight < 600 || screenWidth < 300;
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
                Provider.of<MixPanelProvider>(context, listen: false)
                    .logEvent(eventName: 'Report Participant Screen');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const ReportParticipant();
                    },
                    settings: const RouteSettings(name: 'Report_Participant'),
                  ),
                );
              },
              child: BodyContentArrow(name: appLocalizations.reportParticipant),
            ),
            SizedBox(
              height: isVerySmallScreen
                  ? screenHeight * 0.575
                  : isSmallScreen
                      ? screenHeight * 0.625
                      : screenHeight * 0.66,
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
                        .logEvent(eventName: 'Share Group Code');
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
            SizedBox(height: screenHeight * 0.05),
            OtherOptions(
              onPressed: () {
                Provider.of<MixPanelProvider>(context, listen: false)
                    .logEvent(eventName: 'Exit Group');
                createGroupProvider.confirmExitGroup(
                  context,
                  groups.id,
                );
              },
              text: appLocalizations.exitGroup,
              color: GPColors.red,
            ),
            SizedBox(height: context.screenHeight * 0.05),
          ],
        ),
      ),
    );
  }
}
