import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/large_body.dart';
import 'package:groupup/models/group_model.dart';
import 'package:groupup/core/providers/create_group_provider.dart';
import 'package:groupup/core/widgets/buttons/share_button.dart';
import 'package:groupup/screens/individual_group_settings/components/body_content_arrow.dart';
import 'package:groupup/screens/individual_group_settings/components/body_content_switch.dart';
import 'package:groupup/screens/individual_group_settings/components/other_options.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/screens/individual_group_settings/edit_fields/edit_dates/edit_group_dates.dart';
import 'package:groupup/screens/individual_group_settings/edit_fields/edit_max_participants/edit_group_max_participants.dart';
import 'package:groupup/screens/individual_group_settings/edit_fields/edit_objective/edit_group_objective.dart';
import 'package:groupup/screens/individual_group_settings/edit_fields/edit_project_name/edit_group_name.dart';
import 'package:groupup/screens/individual_group_settings/edit_fields/edit_reward/edit_group_reward.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class BodyNotAdminSettings extends StatelessWidget {
  const BodyNotAdminSettings({required this.groups});

  final GroupModel groups;

  @override
  Widget build(BuildContext context) {
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
                      return EditGroupNameScreen(groups: groups);
                    },
                  ),
                );
              },
              child: const BodyContentArrow(name: 'Report a problem'),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.625),
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.075),
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
