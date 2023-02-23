import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/models/participant.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IndividualParticipant extends StatelessWidget {
  const IndividualParticipant({required this.participant});

  final Participant participant;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: ButtonCommonStyle(
        onPressed: () {
          Provider.of<MixPanelProvider>(context, listen: false)
              .logEvent(eventName: 'Report Participant');
          final group =
              Provider.of<IndividualGroupProvider>(context, listen: false)
                  .group;
          if (group == null) {
            return;
          }
          final Uri emailLaunchUri = Uri(
            scheme: 'mailto',
            path: 'groupupapp@outlook.com',
            query: AppLocalizations.of(context).mailReportParticipant(
              participant.name,
              participant.uid,
              group.projectName,
              group.id,
            ),
          );
          launchUrl(emailLaunchUri);
        },
        child: Row(
          children: [
            if (participant.profilePicture.isEmpty)
              const CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                    'https://firebasestorage.googleapis.com/v0/b/groupup-432b8.appspot.com/o/picture.png?alt=media&token=7707d961-1680-4575-bcf2-89b5e5b93bad'),
              )
            else
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                  participant.profilePicture,
                ),
              ),
            const SizedBox(width: kDefaultPadding),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: Align(
                alignment: Alignment.centerLeft,
                child: StaticText(
                  text: Characters(participant.name)
                      .replaceAll(Characters(''), Characters('\u{200B}'))
                      .toString(),
                  overflow: TextOverflow.ellipsis,
                  fontSize: 20,
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: 60,
              child: SvgPicture.asset(
                'assets/icons/arrow_right.svg',
                color: Colors.black,
                height: 20,
                width: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
