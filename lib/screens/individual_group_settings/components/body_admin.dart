import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/widgets/texts/large_body.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/group_model.dart';
import 'package:groupup/core/providers/create_group_provider.dart';
import 'package:groupup/core/widgets/buttons/share_button.dart';
import 'package:groupup/screens/individual_group_settings/components/body_content_arrow.dart';
import 'package:groupup/screens/individual_group_settings/components/body_content_switch.dart';
import 'package:groupup/screens/individual_group_settings/components/other_options.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/screens/individual_group_settings/edit_fields/edit_dates/edit_group_dates.dart';
import 'package:groupup/screens/individual_group_settings/edit_fields/edit_no_participants/edit_no_participants_screen.dart';
import 'package:groupup/screens/individual_group_settings/edit_fields/edit_objective/edit_group_objective.dart';
import 'package:groupup/screens/individual_group_settings/edit_fields/edit_project_name/edit_group_name.dart';
import 'package:groupup/screens/report_participant/screens/report_participant.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BodyAdminSettings extends StatelessWidget {
  const BodyAdminSettings({required this.groups});

  final GroupModel groups;

  @override
  Widget build(BuildContext context) {
    final participantsData = groups.participantsData;
    final createGroupProvider =
        Provider.of<CreateGroupProvider>(context, listen: false);
    final appLocalizations = AppLocalizations.of(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
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
            SizedBox(height: screenHeight * 0.035),
            ButtonCommonStyle(
              onPressed: () {
                Provider.of<MixPanelProvider>(context, listen: false)
                    .logEvent(eventName: 'Edit Group Name');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return EditGroupNameScreen(groups: groups);
                    },
                    settings: const RouteSettings(name: 'Edit_Group_Name'),
                  ),
                );
              },
              child: BodyContentArrow(name: appLocalizations.projectName),
            ),
            SizedBox(height: screenHeight * 0.035),
            ButtonCommonStyle(
              onPressed: () {
                Provider.of<MixPanelProvider>(context, listen: false)
                    .logEvent(eventName: 'Edit Group Objective');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return EditGroupObjectiveScreen(groups: groups);
                    },
                    settings: const RouteSettings(name: 'Edit_Group_Objective'),
                  ),
                );
              },
              child: BodyContentArrow(name: appLocalizations.objective),
            ),
            SizedBox(height: screenHeight * 0.035),
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
                        title: StaticText(
                          text: appLocalizations.youCantDoThis,
                          textAlign: TextAlign.center,
                          fontFamily: 'Montserrat-SemiBold',
                          fontSize: TextSize.lBody,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        content: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kDefaultPadding),
                          child: StaticText(
                            text: appLocalizations
                                .cantChangeDatesWhenParticipantAddedData,
                            maxLines: 5,
                            textAlign: TextAlign.center,
                            fontSize: TextSize.mBody,
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
                                Navigator.of(context).pop();
                              },
                              child: const StaticText(
                                text: 'OK',
                                fontSize: TextSize.mBody,
                                color: kPrimaryColor,
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
                        return EditGroupDatesScreen(groups: groups);
                      },
                      settings: const RouteSettings(name: 'Edit_Group_Dates'),
                    ),
                  );
                }
              },
              child: BodyContentArrow(name: appLocalizations.dates),
            ),
            SizedBox(height: screenHeight * 0.035),
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
                        title: StaticText(
                          text: appLocalizations.youCantDoThis,
                          textAlign: TextAlign.center,
                          fontFamily: 'Montserrat-SemiBold',
                          fontSize: TextSize.lBody,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        content: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kDefaultPadding),
                          child: StaticText(
                            text: appLocalizations
                                .cantChangeNumberParticipantsWhenParticipantAddedData,
                            maxLines: 5,
                            textAlign: TextAlign.center,
                            fontSize: TextSize.mBody,
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
                                Navigator.of(context).pop();
                              },
                              child: const StaticText(
                                text: 'OK',
                                fontSize: TextSize.mBody,
                                color: kPrimaryColor,
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
                        return EditGroupNoParticipantsScreen(groups: groups);
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
            SizedBox(height: screenHeight * 0.035),
            BodyContentSwitch(
              groups: groups,
              text: appLocalizations.everyoneCanEditGroupPic,
              boolValue: groups.allowEditImage,
            ),
            SizedBox(
              height: isVerySmallScreen
                  ? screenHeight * 0.17
                  : isSmallScreen
                      ? screenHeight * 0.25
                      : screenHeight * 0.315,
            ),
            Row(
              children: [
                SizedBox(
                  width: isVerySmallScreen
                      ? screenWidth * 0.4
                      : screenWidth * 0.35,
                  child: LargeBody(text: appLocalizations.groupCode),
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
                const SizedBox(width: kDefaultPadding / 4),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.05,
            ),
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
              color: Colors.red,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          ],
        ),
      ),
    );
  }
}
