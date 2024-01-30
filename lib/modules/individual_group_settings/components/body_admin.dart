import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/extensions/gp_navigator_extension.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/widgets/loading/gp_loading.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';
import 'package:groupup/core/providers/create_group_provider.dart';
import 'package:groupup/core/widgets/buttons/share_button.dart';
import 'package:groupup/core/widgets/texts/gp_text_header.dart';
import 'package:groupup/modules/individual_group_settings/components/body_content_arrow.dart';
import 'package:groupup/modules/individual_group_settings/components/body_content_switch.dart';
import 'package:groupup/modules/individual_group_settings/components/other_options.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/modules/individual_group_settings/edit_fields/edit_dates/edit_group_dates.dart';
import 'package:groupup/modules/individual_group_settings/edit_fields/edit_no_participants/edit_no_participants_screen.dart';
import 'package:groupup/modules/individual_group_settings/edit_fields/edit_objective/edit_group_objective.dart';
import 'package:groupup/modules/individual_group_settings/edit_fields/edit_project_name/edit_group_name.dart';
import 'package:groupup/modules/individual_group_settings/edit_fields/edit_reward/edit_group_reward.dart';
import 'package:groupup/modules/report_participant/screens/report_participant.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BodyAdminSettings extends StatelessWidget {
  const BodyAdminSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final group = Provider.of<IndividualGroupProvider>(context).group;
    if (group == null) {
      return const GPLoading();
    }
    final participantsData = group.participantsData;
    final createGroupProvider =
        Provider.of<CreateGroupProvider>(context, listen: false);
    final appLocalizations = AppLocalizations.of(context)!;
    final isSmallScreen = context.screenHeight < 800 || context.screenWidth < 350;
    final isVerySmallScreen = context.screenHeight < 600 || context.screenWidth < 300;
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
            SizedBox(height: context.screenHeight * 0.035),
            ButtonCommonStyle(
              onPressed: () {
                Provider.of<MixPanelProvider>(context, listen: false)
                    .logEvent(eventName: 'Edit Group Name');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const EditGroupNameScreen();
                    },
                    settings: const RouteSettings(name: 'Edit_Group_Name'),
                  ),
                );
              },
              child: BodyContentArrow(name: appLocalizations.projectName),
            ),
            SizedBox(height: context.screenHeight * 0.035),
            ButtonCommonStyle(
              onPressed: () {
                Provider.of<MixPanelProvider>(context, listen: false)
                    .logEvent(eventName: 'Edit Group Objective');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const EditGroupObjectiveScreen();
                    },
                    settings: const RouteSettings(name: 'Edit_Group_Objective'),
                  ),
                );
              },
              child: BodyContentArrow(name: appLocalizations.objective),
            ),
            SizedBox(height: context.screenHeight * 0.035),
            ButtonCommonStyle(
              onPressed: () {
                Provider.of<MixPanelProvider>(context, listen: false)
                    .logEvent(eventName: 'Edit Group Reward');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const EditGroupRewardScreen();
                    },
                    settings: const RouteSettings(name: 'Edit_Group_Reward'),
                  ),
                );
              },
              child: BodyContentArrow(name: appLocalizations.reward),
            ),
            SizedBox(height: context.screenHeight * 0.035),
            ButtonCommonStyle(
              onPressed: () {
                Provider.of<MixPanelProvider>(context, listen: false)
                    .logEvent(eventName: 'Edit Group Dates');
                if (participantsData
                        .any((element) => element.inputData.isNotEmpty) ==
                    true) {
                  showCupertinoDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: GPTextHeader(
                          text: appLocalizations.youCantDoThis,
                          textAlign: TextAlign.center,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        content: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kDefaultPadding),
                          child: GPTextBody(
                            text: appLocalizations
                                .cantChangeDatesWhenParticipantAddedData,
                            maxLines: 5,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        actionsAlignment: MainAxisAlignment.center,
                        contentPadding:
                            const EdgeInsets.only(top: 20, bottom: 20),
                        actions: [
                          SizedBox(
                            width: double.infinity,
                            child: ButtonCommonStyle(
                              onPressed: () {
                                Provider.of<MixPanelProvider>(context,
                                        listen: false)
                                    .logEvent(eventName: "Can't Change Dates");
                                context.pop();
                              },
                              child: const GPTextBody(
                                text: 'OK',
                                color: GPColors.primaryColor,
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const EditGroupDatesScreen();
                      },
                      settings: const RouteSettings(name: 'Edit_Group_Dates'),
                    ),
                  );
                }
              },
              child: BodyContentArrow(name: appLocalizations.dates),
            ),
            SizedBox(height: context.screenHeight * 0.035),
            ButtonCommonStyle(
              onPressed: () {
                Provider.of<MixPanelProvider>(context, listen: false)
                    .logEvent(eventName: 'Edit No Participants');
                if (participantsData
                        .any((element) => element.inputData.isNotEmpty) ==
                    true) {
                  showCupertinoDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: GPTextHeader(
                          text: appLocalizations.youCantDoThis,
                          textAlign: TextAlign.center,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        content: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kDefaultPadding),
                          child: GPTextBody(
                            text: appLocalizations
                                .cantChangeNumberParticipantsWhenParticipantAddedData,
                            maxLines: 5,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        actionsAlignment: MainAxisAlignment.center,
                        contentPadding:
                            const EdgeInsets.only(top: 20, bottom: 20),
                        actions: [
                          SizedBox(
                            width: double.infinity,
                            child: ButtonCommonStyle(
                              onPressed: () {
                                Provider.of<MixPanelProvider>(
                                  context,
                                  listen: false,
                                ).logEvent(
                                    eventName: "Can't Edit No Participants");
                                context.pop();
                              },
                              child: const GPTextBody(
                                text: 'OK',
                                color: GPColors.primaryColor,
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const EditGroupNoParticipantsScreen();
                      },
                      settings: const RouteSettings(
                          name: 'Edit_Group_No_Participants'),
                    ),
                  );
                }
              },
              child: BodyContentArrow(
                name: appLocalizations.numberParticipants,
                maxLine: 2,
              ),
            ),
            SizedBox(height: context.screenHeight * 0.035),
            BodyContentSwitch(
              text: appLocalizations.everyoneCanEditGroupPic,
              boolValue: group.allowEditImage,
            ),
            SizedBox(
              height: isVerySmallScreen
                  ? context.screenHeight * 0.17
                  : isSmallScreen
                      ? context.screenHeight * 0.25
                      : context.screenHeight * 0.26,
            ),
            Row(
              children: [
                SizedBox(
                  width: isVerySmallScreen
                      ? context.screenWidth * 0.4
                      : context.screenWidth * 0.35,
                  child: GPTextBody(
                    text: appLocalizations.groupCode,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                ShareButton(
                  text: group.groupCode,
                  onPressed: () async {
                    Provider.of<MixPanelProvider>(context, listen: false)
                        .logEvent(eventName: 'Share Group Code');
                    await Share.share(
                      appLocalizations.shareGroupCodeText(
                        group.projectName,
                        group.groupCode,
                      ),
                    );
                  },
                ),
                const SizedBox(width: kDefaultPadding / 4),
              ],
            ),
            SizedBox(
              height: context.screenHeight * 0.05,
            ),
            OtherOptions(
              onPressed: () {
                Provider.of<MixPanelProvider>(context, listen: false)
                    .logEvent(eventName: 'Exit Group');
                createGroupProvider.confirmExitGroup(
                  context,
                  group.id,
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
