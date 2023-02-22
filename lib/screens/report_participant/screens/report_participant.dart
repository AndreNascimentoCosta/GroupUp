import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/report_participant/components/app_bar_report_participants.dart';
import 'package:groupup/screens/report_participant/components/body_report_participant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReportParticipant extends StatelessWidget {
  const ReportParticipant({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarReportParticipant(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: kDefaultPadding),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: StaticText(
              text: AppLocalizations.of(context).infoReportParticipant,
              maxLines: 7,
              fontSize: TextSize.sBody,
            ),
          ),
          const SizedBox(height: kDefaultPadding),
          const BodyReportParticipant(),
        ],
      ),
    );
  }
}
