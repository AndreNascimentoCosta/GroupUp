import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/utils/icons/gp_icons.dart';
import 'package:groupup/core/widgets/icons/gp_icon.dart';
import 'package:groupup/core/constants/design-system.dart';
import 'package:groupup/core/widgets/loading/gp_loading.dart';
import 'package:groupup/models/dropdown_model.dart';
import 'package:groupup/models/participant.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GroupEndedParticipantCard extends StatefulWidget {
  const GroupEndedParticipantCard({
    Key? key,
    required this.participant,
  }) : super(key: key);

  final Participant participant;

  @override
  State<GroupEndedParticipantCard> createState() =>
      _GroupEndedParticipantCardState();
}

class _GroupEndedParticipantCardState extends State<GroupEndedParticipantCard> {
  bool isChecked = false;
  final DropDownModel dropDownModel = DropDownModel();

  @override
  Widget build(BuildContext context) {
    final individualGroupProvider =
        Provider.of<IndividualGroupProvider>(context, listen: false);
    final appLocalizations = AppLocalizations.of(context)!;
    if (individualGroupProvider.group == null) {
      return const GPLoading();
    } else {
      final authProvider = Provider.of<AuthProvider>(context);
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: kDefaultPadding / 2,
              ),
              child: SizedBox(
                width: 25,
                child: Text(
                  widget.participant
                      .rank(individualGroupProvider.group)
                      .toString(),
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Montserrat-SemiBold',
                    color: GPColors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(width: kDefaultPadding / 2),
            widget.participant.profilePicture.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(Insets.l * 4),
                    child: Container(
                      height: Insets.l * 2,
                      width: Insets.l * 2,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            widget.participant.profilePicture,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )
                : const CircleAvatar(
                    radius: Insets.l,
                    backgroundColor: GPColors.lightGray,
                    child: GPIcon(
                      GPIcons.profilePictureAdd,
                      color: GPColors.white,
                      height: Insets.l,
                      width: Insets.l,
                    ),
                  ),
            authProvider.user != null
                ? authProvider.user!.id == widget.participant.uid
                    ? Padding(
                        padding: const EdgeInsets.only(
                          left: kDefaultPadding,
                        ),
                        child: Text(
                          appLocalizations.me,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'Montserrat-SemiBold',
                            color: GPColors.black,
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(
                          left: kDefaultPadding,
                        ),
                        child: Text(
                          Characters(widget.participant.name)
                              .replaceAll(
                                Characters(''),
                                Characters('\u{200B}'),
                              )
                              .toString(),
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'Montserrat-SemiBold',
                            color: GPColors.black,
                          ),
                        ),
                      )
                : const Text(
                    '',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Montserrat-SemiBold',
                      color: GPColors.black,
                    ),
                  ),
          ],
        ),
      );
    }
  }
}
