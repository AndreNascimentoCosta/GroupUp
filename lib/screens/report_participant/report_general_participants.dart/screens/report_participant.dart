import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/report_participant/report_general_participants.dart/components/app_bar_report_participants.dart';
import 'package:groupup/screens/report_participant/report_general_participants.dart/components/body_report_participant.dart';

class ReportParticipant extends StatelessWidget {
  const ReportParticipant({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarReportParticipant(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          SizedBox(height: kDefaultPadding),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: StaticText(
                text:
                    'Info: If a participant is reported by majority, this person will be removed from the group without getting refunded. (This only works when there are at least 3 participants in the group.)',
                maxLines: 3,
                fontSize: TextSize.sBody),
          ),
          SizedBox(height: kDefaultPadding),
          BodyReportParticipant(),
        ],
      ),
    );
  }
}
