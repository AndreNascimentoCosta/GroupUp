import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
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
import 'package:groupup/screens/report_participant/report_general_participants.dart/screens/report_participant.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class BodyAdminSettings extends StatelessWidget {
  const BodyAdminSettings({required this.groups});

  final GroupModel groups;

  @override
  Widget build(BuildContext context) {
    final participantsData = groups.participantsData;
    final createGroupProvider =
        Provider.of<CreateGroupProvider>(context, listen: false);
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const ReportParticipant();
                    },
                  ),
                );
              },
              child: const BodyContentArrow(name: 'Report a participant'),
            ),
            const SizedBox(height: kDefaultPadding * 1.5),
            ButtonCommonStyle(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return EditGroupNameScreen(groups: groups);
                    },
                  ),
                );
              },
              child: const BodyContentArrow(name: 'Project name'),
            ),
            const SizedBox(height: kDefaultPadding * 1.5),
            ButtonCommonStyle(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return EditGroupObjectiveScreen(groups: groups);
                    },
                  ),
                );
              },
              child: const BodyContentArrow(name: 'Objective'),
            ),
            const SizedBox(height: kDefaultPadding * 1.5),
            ButtonCommonStyle(
              onPressed: () {
                if (participantsData.any((element) => element.hasStory) ==
                    true) {
                  showCupertinoDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const StaticText(
                          text: "You can't do this",
                          textAlign: TextAlign.center,
                          fontFamily: 'Montserrat-SemiBold',
                          fontSize: TextSize.lBody,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        content: const StaticText(
                          text:
                              "A participant has already added \ndata. You can't change the dates anymore.",
                          maxLines: 5,
                          textAlign: TextAlign.center,
                          fontSize: TextSize.mBody,
                        ),
                        actionsAlignment: MainAxisAlignment.center,
                        contentPadding:
                            const EdgeInsets.only(top: 20, bottom: 20),
                        actions: [
                          ButtonCommonStyle(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const StaticText(
                              text: 'OK',
                              fontSize: TextSize.mBody,
                              color: kPrimaryColor,
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
                    ),
                  );
                }
              },
              child: const BodyContentArrow(name: 'Dates'),
            ),
            const SizedBox(height: kDefaultPadding * 1.5),
            ButtonCommonStyle(
              onPressed: () {
                if (participantsData.any((element) => element.hasStory) ==
                    true) {
                  showCupertinoDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const StaticText(
                          text: "You can't do this",
                          textAlign: TextAlign.center,
                          fontFamily: 'Montserrat-SemiBold',
                          fontSize: TextSize.lBody,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        content: const StaticText(
                          text:
                              "A participant has already added \ndata. You can't change the dates anymore.",
                          maxLines: 5,
                          textAlign: TextAlign.center,
                          fontSize: TextSize.mBody,
                        ),
                        actionsAlignment: MainAxisAlignment.center,
                        contentPadding:
                            const EdgeInsets.only(top: 20, bottom: 20),
                        actions: [
                          ButtonCommonStyle(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const StaticText(
                              text: 'OK',
                              fontSize: TextSize.mBody,
                              color: kPrimaryColor,
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
                    ),
                  );
                }
              },
              child: const BodyContentArrow(
                name: 'Number of participants',
                maxLine: 2,
              ),
            ),
            const SizedBox(height: kDefaultPadding * 1.5),
            const SizedBox(height: kDefaultPadding * 1.5),
            BodyContentSwitch(
              groups: groups,
              text: 'Everyone can edit group picture',
              boolValue: groups.allowEditImage,
            ),
            const SizedBox(height: kDefaultPadding * 1.5),
            SizedBox(height: MediaQuery.of(context).size.height * 0.3),
            Row(
              children: [
                const SizedBox(
                  width: 150,
                  child: LargeBody(text: 'Group code'),
                ),
                const Spacer(),
                ShareButton(
                  text: groups.groupCode,
                  onPressed: () async {
                    await Share.share(
                        'Join my group ${groups.projectName} on GroupUp! \nThe code is ${groups.groupCode}');
                  },
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.175),
            OtherOptions(
              onPressed: () {
                createGroupProvider.confirmExitGroup(
                  context,
                  groups.id,
                );
              },
              text: 'Exit group',
              color: Colors.red,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          ],
        ),
      ),
    );
  }
}
