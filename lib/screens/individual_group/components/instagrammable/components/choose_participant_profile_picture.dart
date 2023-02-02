import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/core/providers/instagrammable_provider.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/groups/components/dropdown.dart';
import 'package:groupup/models/participant.dart';
import 'package:provider/provider.dart';

class ChooseParticipantProfilePicture extends StatefulWidget {
  const ChooseParticipantProfilePicture({
    Key? key,
    required this.participant,
  }) : super(key: key);

  final Participant participant;

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
    final individualGroupProvider =
        Provider.of<IndividualGroupProvider>(context, listen: false);
    if (individualGroupProvider.group == null) {
      return const CircularProgressIndicator(color: kPrimaryColor);
    } else {
      final authProvider = Provider.of<AuthProvider>(context);
      return ButtonCommonStyle(
        onPressed: () {
          final placeholderPicture =
              Provider.of<InstagrammableProvider>(context, listen: false)
                  .picture;
          setState(
            () {
              widget.participant.profilePicture = placeholderPicture;
              Navigator.of(context).pop();
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Row(
            children: [
              widget.participant.profilePicture.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(Insets.l * 4),
                      child: CachedNetworkImage(
                        imageUrl: widget.participant.profilePicture,
                        fadeInDuration: const Duration(milliseconds: 100),
                        height: Insets.l * 2,
                        width: Insets.l * 2,
                        fit: BoxFit.cover,
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
                width: 180,
                child: authProvider.user != null
                    ? authProvider.user!.id == widget.participant.uid
                        ? const Padding(
                            padding: EdgeInsets.only(
                              left: kDefaultPadding,
                            ),
                            child: StaticText(
                              text: 'Me',
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
                                      Characters(''), Characters('\u{200B}'))
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
