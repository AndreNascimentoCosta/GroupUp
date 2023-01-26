import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/providers/report_participant_provider.dart';
import 'package:groupup/core/widgets/texts/large_body.dart';
import 'package:groupup/models/group_model.dart';
import 'package:groupup/core/providers/create_group_provider.dart';
import 'package:groupup/core/widgets/buttons/share_button.dart';
import 'package:groupup/screens/individual_group_settings/components/body_content_arrow.dart';
import 'package:groupup/screens/individual_group_settings/components/other_options.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../report_participant/report_general_participants.dart/screens/report_participant.dart';

class BodyNotAdminSettings extends StatelessWidget {
  const BodyNotAdminSettings({required this.groups});

  final GroupModel groups;

  @override
  Widget build(BuildContext context) {
    final createGroupProvider =
        Provider.of<CreateGroupProvider>(context, listen: false);
    return ChangeNotifierProvider(
      create: (context) => ReportParticipantProvider(),
      child: Padding(
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
      ),
    );
  }
}
