import 'package:flutter/material.dart';
import 'package:groupup/screens/report_participant/report_general_participants.dart/components/app_bar_report_participants.dart';
import 'package:groupup/screens/report_participant/report_general_participants.dart/components/body_report_participant.dart';

class ReportParticipant extends StatelessWidget {
  const ReportParticipant({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarReportParticipant(),
      body: Column(
        children: const [
          BodyReportParticipant(),
        ],
      ),
    );
  }
}