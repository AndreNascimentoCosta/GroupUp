import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/core/widgets/texts/extra_large_body.dart';
import 'package:groupup/core/widgets/texts/large_body.dart';
import 'package:groupup/core/widgets/texts/medium_body.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/groups/components/dropdown.dart';
import 'package:groupup/models/participant.dart';
import 'package:groupup/models/home_view.dart';
import 'package:provider/provider.dart';

import '../../../core/providers/auth_provider.dart';

class GroupEndedParticipantCard extends StatefulWidget {
  const GroupEndedParticipantCard({
    Key? key,
    required this.participant,
    required this.homeViewModel,
  }) : super(key: key);

  final Participant participant;
  final HomeViewModel homeViewModel;

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
    if (individualGroupProvider.group == null) {
      return const CircularProgressIndicator(color: kPrimaryColor);
    } else {
      final authProvider = Provider.of<AuthProvider>(context);
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: ValueListenableBuilder(
          valueListenable: widget.homeViewModel.isEditing,
          builder: (context, value, child) {
            return Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: kDefaultPadding / 2,
                  ),
                  child: SizedBox(
                    width: 25,
                    child: MediumBody(
                        text: widget.participant.rank(context)),
                  ),
                ),
                const SizedBox(width: kDefaultPadding / 2),
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
                                    .replaceAll(Characters(''),
                                        Characters('\u{200B}'))
                                    .toString(),
                                overflow: TextOverflow.ellipsis,
                                fontSize: TextSize.mBody,
                              ),
                            )
                      : const StaticText(text: ''),
                ),
              ],
            );
          },
        ),
      );
    }
  }
}
