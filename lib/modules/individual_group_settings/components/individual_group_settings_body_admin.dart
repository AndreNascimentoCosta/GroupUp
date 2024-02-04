import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/extensions/gp_navigator_extension.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/widgets/buttons/switch_button.dart';
import 'package:groupup/core/widgets/loading/gp_loading.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';
import 'package:groupup/core/providers/create_group_provider.dart';
import 'package:groupup/core/widgets/buttons/share_button.dart';
import 'package:groupup/core/widgets/texts/gp_text_header.dart';
import 'package:groupup/modules/individual_group_settings/components/individual_group_settings_common_button.dart';
import 'package:groupup/modules/individual_group_settings/components/individual_group_settings_events.dart';
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

class IndividualGroupSettingBodyAdmin extends StatelessWidget {
  const IndividualGroupSettingBodyAdmin({super.key});

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
                  const ReportParticipant(),
                );
              },
              child: IndividualGroupSettingCommonButton(
                name: appLocalizations.reportParticipant,
              ),
            ),
            SizedBox(height: context.screenHeight * 0.035),
            ButtonCommonStyle(
              onPressed: () {
                Provider.of<MixPanelProvider>(context, listen: false).logEvent(
                  eventName:
                      IndividualGroupSettingsEvents.pressEditGroupName.value,
                );
                context.push(
                  const EditGroupNameScreen(),
                );
              },
              child: IndividualGroupSettingCommonButton(
                name: appLocalizations.projectName,
              ),
            ),
            SizedBox(height: context.screenHeight * 0.035),
            ButtonCommonStyle(
              onPressed: () {
                Provider.of<MixPanelProvider>(context, listen: false).logEvent(
                  eventName: IndividualGroupSettingsEvents
                      .pressEditGroupObjetive.value,
                );
                context.push(
                  const EditGroupObjectiveScreen(),
                );
              },
              child: IndividualGroupSettingCommonButton(
                name: appLocalizations.objective,
              ),
            ),
            SizedBox(height: context.screenHeight * 0.035),
            ButtonCommonStyle(
              onPressed: () {
                Provider.of<MixPanelProvider>(context, listen: false).logEvent(
                  eventName:
                      IndividualGroupSettingsEvents.pressEditGroupReward.value,
                );
                context.push(
                  const EditGroupRewardScreen(),
                );
              },
              child: IndividualGroupSettingCommonButton(
                name: appLocalizations.reward,
              ),
            ),
            SizedBox(height: context.screenHeight * 0.035),
            ButtonCommonStyle(
              onPressed: () {
                Provider.of<MixPanelProvider>(context, listen: false).logEvent(
                  eventName:
                      IndividualGroupSettingsEvents.pressEditGroupDates.value,
                );
                if (participantsData.any(
                      (element) => element.inputData.isNotEmpty,
                    ) ==
                    true) {
                  showCupertinoDialog(
                    context: context,
                    builder: (
                      BuildContext context,
                    ) {
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
                            horizontal: kDefaultPadding,
                          ),
                          child: GPTextBody(
                            text: appLocalizations
                                .cantChangeDatesWhenParticipantAddedData,
                            maxLines: 5,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        actionsAlignment: MainAxisAlignment.center,
                        contentPadding: const EdgeInsets.only(
                          top: 20,
                          bottom: 20,
                        ),
                        actions: [
                          SizedBox(
                            width: double.infinity,
                            child: ButtonCommonStyle(
                              onPressed: () {
                                Provider.of<MixPanelProvider>(context,
                                        listen: false)
                                    .logEvent(
                                  eventName: IndividualGroupSettingsEvents
                                      .pressOkCantChangeDates.value,
                                );
                                context.pop();
                              },
                              child: GPTextBody(
                                text: appLocalizations.ok,
                                color: GPColors.primaryColor,
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  );
                } else {
                  context.push(
                    const EditGroupDatesScreen(),
                  );
                }
              },
              child: IndividualGroupSettingCommonButton(
                name: appLocalizations.dates,
              ),
            ),
            SizedBox(height: context.screenHeight * 0.035),
            ButtonCommonStyle(
              onPressed: () {
                Provider.of<MixPanelProvider>(context, listen: false).logEvent(
                  eventName: IndividualGroupSettingsEvents
                      .pressEditNumberOfParticipants.value,
                );
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
                                  eventName: IndividualGroupSettingsEvents
                                      .pressOkCantEditNumberOfParticipants
                                      .value,
                                );
                                context.pop();
                              },
                              child: GPTextBody(
                                text: appLocalizations.ok,
                                color: GPColors.primaryColor,
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  );
                } else {
                  context.push(
                    const EditGroupNoParticipantsScreen(),
                  );
                }
              },
              child: IndividualGroupSettingCommonButton(
                name: appLocalizations.numberParticipants,
                maxLine: 2,
              ),
            ),
            SizedBox(height: context.screenHeight * 0.035),
            Row(
              children: [
                SizedBox(
                  width: context.isVerySmallScreen
                      ? context.screenWidth * 0.675
                      : context.screenWidth * 0.65,
                  child: GPTextBody(
                    text: appLocalizations.everyoneCanEditGroupPic,
                    maxLines: 2,
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                SwitchButton(
                  onChanged: (value) {
                    createGroupProvider.updateAllowEditImage(
                      context,
                      value,
                      group.id,
                    );
                  },
                  boolValue: group.allowEditImage,
                ),
              ],
            ),
            SizedBox(
              height: context.isVerySmallScreen
                  ? context.screenHeight * 0.17
                  : context.isSmallScreen
                      ? context.screenHeight * 0.25
                      : context.screenHeight * 0.26,
            ),
            Row(
              children: [
                SizedBox(
                  width: context.isVerySmallScreen
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
                        .logEvent(
                      eventName:
                          IndividualGroupSettingsEvents.shareGroupCode.value,
                    );
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
            ButtonCommonStyle(
              onPressed: () {
                Provider.of<MixPanelProvider>(context, listen: false).logEvent(
                  eventName: IndividualGroupSettingsEvents.pressExitGroup.value,
                );
                createGroupProvider.confirmExitGroup(
                  context,
                  group.id,
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
