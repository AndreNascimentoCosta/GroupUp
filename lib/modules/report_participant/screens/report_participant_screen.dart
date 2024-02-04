import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/widgets/app_bar/gp_app_bar.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';
import 'package:groupup/modules/report_participant/components/report_participant_body.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:groupup/modules/report_participant/components/report_participant_events.dart';

class ReportParticipantScreen extends StatelessWidget {
  const ReportParticipantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GPAppBar(
        headerText: AppLocalizations.of(context)!.reportParticipant,
        eventName: ReportParticipantEvents
            .pressBackButtonReportParticipantScreen.value,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: kDefaultPadding),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: GPTextBody(
              text: AppLocalizations.of(context)!.infoReportParticipant,
              maxLines: 7,
            ),
          ),
          const SizedBox(height: kDefaultPadding),
          const ReportParticipantBody(),
        ],
      ),
    );
  }
}
