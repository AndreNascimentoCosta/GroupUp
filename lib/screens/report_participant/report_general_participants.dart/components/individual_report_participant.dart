import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/models/participant.dart';
import 'package:provider/provider.dart';
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
          final group =
              Provider.of<IndividualGroupProvider>(context, listen: false)
                  .group;
          if (group == null) {
            return;
          }
          final Uri emailLaunchUri = Uri(
            scheme: 'mailto',
            path: 'groupupapp@outlook.com',
            query:
                'subject=Report a problem&body=I would like to report ${participant.name} (${participant.uid}) from the group ${group.projectName} (${group.id}) for the following reason: ',
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
            SizedBox(
              width: 220,
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
