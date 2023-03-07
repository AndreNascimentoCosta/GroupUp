import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/core/providers/instagrammable_provider.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/groups/components/dropdown.dart';
import 'package:groupup/models/participant.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChooseParticipantProfilePicture extends StatefulWidget {
  const ChooseParticipantProfilePicture({
    Key? key,
    required this.participant,
    required this.pictureType,
  }) : super(key: key);

  final Participant participant;
  final SetPictureType pictureType;

  @override
  State<ChooseParticipantProfilePicture> createState() =>
      _ChooseParticipantProfilePictureState();
}

class _ChooseParticipantProfilePictureState
    extends State<ChooseParticipantProfilePicture> {
  bool isChecked = false;
  final DropDownModel dropDownModel = DropDownModel();

  @override
  Widget build(BuildContext context) {
    const placholderImage =
        'https://firebasestorage.googleapis.com/v0/b/groupup-432b8.appspot.com/o/picture.png?alt=media&token=7707d961-1680-4575-bcf2-89b5e5b93bad';
    final individualGroupProvider =
        Provider.of<IndividualGroupProvider>(context, listen: false);
    final appLocalizations = AppLocalizations.of(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenHeight < 800 || screenWidth < 350;
    final isVerySmallScreen = screenHeight < 600 || screenWidth < 300;
    if (individualGroupProvider.group == null) {
      return const CircularProgressIndicator.adaptive();
    } else {
      final authProvider = Provider.of<AuthProvider>(context);
      return ButtonCommonStyle(
        onPressed: () {
          Provider.of<MixPanelProvider>(context, listen: false).logEvent(
              eventName: 'Choose Participant Profile Picture Instagrammable');
          Provider.of<InstagrammableProvider>(context, listen: false)
              .setPicture(
                  widget.participant.profilePicture.isEmpty
                      ? placholderImage
                      : widget.participant.profilePicture,
                  widget.pictureType);
          Navigator.of(context).pop();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Row(
            children: [
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
                  : CircleAvatar(
                      radius: Insets.l,
                      backgroundColor: const Color(0XFFE1E1E1),
                      child: SvgPicture.asset(
                        'assets/icons/profile_picture_add.svg',
                        color: Colors.white,
                        height: Insets.l,
                        width: Insets.l,
                      ),
                    ),
              SizedBox(
                width: isVerySmallScreen
                    ? Insets.l * 6
                    : isSmallScreen
                        ? Insets.l * 8
                        : Insets.l * 10,
                child: authProvider.user != null
                    ? authProvider.user!.id == widget.participant.uid
                        ? Padding(
                            padding: const EdgeInsets.only(
                              left: kDefaultPadding,
                            ),
                            child: StaticText(
                              text: appLocalizations.me,
                              overflow: TextOverflow.ellipsis,
                              fontSize: TextSize.mBody,
                              fontFamily: 'Montserrat-SemiBold',
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(
                              left: kDefaultPadding,
                            ),
                            child: StaticText(
                              text: Characters(widget.participant.name)
                                  .replaceAll(
                                    Characters(''),
                                    Characters('\u{200B}'),
                                  )
                                  .toString(),
                              overflow: TextOverflow.ellipsis,
                              fontSize: TextSize.mBody,
                            ),
                          )
                    : const StaticText(text: ''),
              ),
            ],
          ),
        ),
      );
    }
  }
}
