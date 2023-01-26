import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/screens/report_participant/report_general_participants.dart/components/individual_report_participant.dart';
import 'package:provider/provider.dart';

class BodyReportParticipant extends StatelessWidget {
  const BodyReportParticipant({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scrollbar(
        child: Builder(
          builder: (context) {
            final participants = Provider.of<IndividualGroupProvider>(context)
                .group
                ?.participantsData;
            if (participants == null) {
              return const Center(
                child: CircularProgressIndicator(color: kPrimaryColor),
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.only(
                top: kDefaultPadding,
              ),
              separatorBuilder: (context, index) => const Divider(
                indent: kDefaultPadding,
                endIndent: kDefaultPadding,
                height: 30,
                thickness: 0.5,
                color: kSecondaryColor,
              ),
              shrinkWrap: true,
              itemCount: participants.length,
              itemBuilder: (context, index) => IndividualParticipant(
                participant: participants[index],
              ),
            );
          },
        ),
      ),
    );
  }
}
