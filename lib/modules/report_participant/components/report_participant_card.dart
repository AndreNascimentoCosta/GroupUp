import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/constants/url_launcher_constants.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/utils/icons/gp_icons.dart';
import 'package:groupup/core/utils/url_launcher/gp_url_launcher.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/widgets/icons/gp_icon.dart';
import 'package:groupup/core/constants/design_system.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';
import 'package:groupup/models/participant_model.dart';
import 'package:groupup/modules/report_participant/components/report_participant_events.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReportParticipantCard extends StatelessWidget {
  const ReportParticipantCard({required this.participant});

  final Participant participant;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: ButtonCommonStyle(
        onPressed: () {
          Provider.of<MixPanelProvider>(context, listen: false).logEvent(
            eventName: ReportParticipantEvents.reportParticipant.value,
          );
          final group =
              Provider.of<IndividualGroupProvider>(context, listen: false)
                  .group;
          if (group == null) {
            return;
          }
          gpUrlLauncher.launch(
            uri: UrlLauncherConstants.emailAddress(
              subject: appLocalizations.reportParticipant,
              body: appLocalizations.mailReportParticipant(
                participant.name,
                participant.uid,
                group.projectName,
                group.id,
              ),
            ),
          );
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
                GPIcons.arrowRight,
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
