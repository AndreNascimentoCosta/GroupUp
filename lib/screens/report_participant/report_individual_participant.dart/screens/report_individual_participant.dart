import 'package:flutter/material.dart';
import 'package:groupup/core/providers/report_participant_provider.dart';
import 'package:groupup/models/participant.dart';
import 'package:groupup/screens/report_participant/report_individual_participant.dart/components/app_bar_report_individual_participant.dart';
import 'package:groupup/screens/report_participant/report_individual_participant.dart/components/body_report_individual_participant.dart';
import 'package:provider/provider.dart';

class ReportIndividualParticipantScreen extends StatelessWidget {
  const ReportIndividualParticipantScreen({required this.participant});

  final Participant participant;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ReportParticipantProvider(),
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          appBar: AppBarReportIndividualParticipant(participant: participant),
          body: const SingleChildScrollView(
            child: BodyReportIndividualParticipant(),
          ),
        ),
      ),
    );
  }
}
