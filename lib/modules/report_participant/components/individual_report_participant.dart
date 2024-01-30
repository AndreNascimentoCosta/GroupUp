import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/utils/icons/gp_icons.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/widgets/icons/gp_icon.dart';
import 'package:groupup/core/constants/design-system.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';
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
            query: AppLocalizations.of(context)!.mailReportParticipant(
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
              Container(
                padding: const EdgeInsets.all(3),
                child: const CircleAvatar(
                  radius: Insets.l * 1.425,
                  backgroundColor: Color(0XFFE1E1E1),
                  child: GPIcon(
                    GPIcons.profilePictureAdd,
                    color: GPColors.white,
                    height: Insets.l * 1.425,
                    width: Insets.l * 1.425,
                  ),
                ),
              )
            else
              ClipRRect(
                borderRadius: BorderRadius.circular(
                  Insets.l * 3,
                ),
                child: Container(
                  height: Insets.l * 3,
                  width: Insets.l * 3,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        participant.profilePicture,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            const SizedBox(width: kDefaultPadding),
            SizedBox(
              width: context.screenWidth * 0.4,
              child: Align(
                alignment: Alignment.centerLeft,
                child: GPTextBody(
                  text: Characters(participant.name)
                      .replaceAll(Characters(''), Characters('\u{200B}'))
                      .toString(),
                  overflow: TextOverflow.ellipsis,
                  fontSize: 20,
                ),
              ),
            ),
            const Spacer(),
            const SizedBox(
              width: 60,
              child: GPIcon(
                GPIcons.arrowLeft,
                color: GPColors.black,
                height: Insets.l,
                width: Insets.l,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
