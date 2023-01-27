import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/models/participant.dart';
import 'package:url_launcher/url_launcher.dart';

class IndividualParticipant extends StatelessWidget {
  const IndividualParticipant({required this.participant});

  final Participant participant;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: ButtonCommonStyle(
        onPressed: () {
          final Uri emailLaunchUri = Uri(
            scheme: 'mailto',
            path: 'groupupapp@outlook.com',
            query:
                'subject=Report a problem&body=I would like to report ${participant.name} (${participant.uid}) for the following reason: ',
          );
          launchUrl(emailLaunchUri);
        },
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(participant.profilePicture),
            ),
            const SizedBox(width: kDefaultPadding),
            Align(
              alignment: Alignment.centerLeft,
              child: StaticText(
                text: participant.name,
                fontSize: 20,
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
