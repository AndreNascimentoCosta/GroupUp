import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/screens/report_participant/components/individual_report_participant.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/widgets/texts/static_text.dart';

class BodyReportParticipant extends StatelessWidget {
  const BodyReportParticipant({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scrollbar(
        child: Builder(
          builder: (context) {
            final currentUser = Provider.of<AuthProvider>(context).user;
            if (currentUser == null) {
              return const Center(
                child: CircularProgressIndicator(color: kPrimaryColor),
              );
            }
            final participants = Provider.of<IndividualGroupProvider>(context)
                .group
                ?.participantsData
                .where((element) => element.uid != currentUser.id)
                .toList();
            if (participants == null) {
              return const Center(
                child: CircularProgressIndicator(color: kPrimaryColor),
              );
            }
            if (participants.isEmpty) {
              return Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: kDefaultPadding),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: StaticText(
                          text: AppLocalizations.of(context).noParticipants,
                          color: kSecondaryColor,
                          textAlign: TextAlign.center,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
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
