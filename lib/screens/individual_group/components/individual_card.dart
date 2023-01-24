import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/core/widgets/texts/extra_large_body.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/groups/components/dropdown.dart';
import 'package:groupup/models/participant.dart';
import 'package:groupup/screens/individual_group/components/chart/comparative_chart.dart';
import 'package:groupup/screens/individual_group/components/chart/label.dart';
import 'package:groupup/screens/individual_group/components/individual_value.dart';
import 'package:groupup/models/home_view.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/screens/individual_group/components/make_admin.dart';
import 'package:provider/provider.dart';

import '../../../core/providers/auth_provider.dart';

class IndividualGroupCard extends StatefulWidget {
  const IndividualGroupCard({
    Key? key,
    required this.participant,
    required this.meParticipant,
    required this.homeViewModel,
  }) : super(key: key);

  final Participant participant;
  final Participant meParticipant;
  final HomeViewModel homeViewModel;

  @override
  State<IndividualGroupCard> createState() => _IndividualGroupCardState();
}

class _IndividualGroupCardState extends State<IndividualGroupCard> {
  bool isChecked = false;
  final DropDownModel dropDownModel = DropDownModel();

  @override
  Widget build(BuildContext context) {
    final individualGroupProvider =
        Provider.of<IndividualGroupProvider>(context, listen: false);
    final currentUserId = Provider.of<AuthProvider>(context).user?.id;
    if (individualGroupProvider.group == null) {
      return const CircularProgressIndicator(color: kPrimaryColor);
    } else {
      final currentUserData =
          individualGroupProvider.group!.participantsData.firstWhere(
        (element) => element.uid == currentUserId,
      );
      final authProvider = Provider.of<AuthProvider>(context);
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Column(
          children: [
            ValueListenableBuilder(
              valueListenable: widget.homeViewModel.isEditing,
              builder: (context, value, child) {
                return ButtonCommonStyle(
                  onPressed: widget.homeViewModel.isEditing.value
                      ? () {
                          currentUserData.isAdmin
                              ? showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(Insets.m),
                                  ),
                                  builder: (context) {
                                    return Padding(
                                      padding:
                                          MediaQuery.of(context).viewInsets,
                                      child: Wrap(
                                        children: <Widget>[
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.15,
                                                child: MakeAdmin(
                                                    participant:
                                                        widget.participant),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                )
                              : null;
                        }
                      : dropDownModel.switchEdit,
                  child: Row(
                    children: [
                      currentUserData.isAdmin
                          ? ValueListenableBuilder(
                              valueListenable: widget.homeViewModel.isEditing,
                              builder: (context, value, child) {
                                return AnimatedContainer(
                                  width: value ? 50 : 0,
                                  duration: const Duration(milliseconds: 50),
                                  child: Visibility(
                                    visible: value,
                                    child: SvgPicture.asset(
                                      'assets/icons/minus.svg',
                                      color: Colors.red,
                                    ),
                                  ),
                                );
                              },
                            )
                          : const SizedBox(),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: kDefaultPadding / 2,
                        ),
                        child: ExtraLargeBody(text: widget.participant.rank),
                      ),
                      const SizedBox(width: kDefaultPadding),
                      widget.participant.profilePicture.isNotEmpty
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(Insets.l * 6),
                              child: CachedNetworkImage(
                                imageUrl: widget.participant.profilePicture,
                                fadeInDuration:
                                    const Duration(milliseconds: 100),
                                height: Insets.l * 3,
                                width: Insets.l * 3,
                                fit: BoxFit.cover,
                              ),
                            )
                          : SvgPicture.asset(
                              'assets/icons/profile_picture_add.svg',
                              color: Colors.white,
                              height: Insets.l * 3,
                              width: Insets.l * 3,
                            ),
                      Expanded(
                        child: authProvider.user != null
                            ? authProvider.user!.id == widget.participant.uid
                                ? const Padding(
                                    padding: EdgeInsets.only(
                                      left: kDefaultPadding,
                                    ),
                                    child: StaticText(
                                      text: 'Me',
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 20,
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
                                      fontSize: 20,
                                    ),
                                  )
                            : const StaticText(text: ''),
                      ),
                      const SizedBox(width: kDefaultPadding /4),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: IndividualValue(
                          homeViewModel: widget.homeViewModel,
                          userInputData: widget.participant.sumData,
                          dropDownModel: dropDownModel,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            ValueListenableBuilder(
              valueListenable: dropDownModel.isOpened,
              builder: (context, value, child) {
                return AnimatedContainer(
                  height: value ? kDefaultPadding : 0,
                  duration: const Duration(milliseconds: 150),
                  child: Visibility(
                    visible: value,
                    child: const SizedBox(
                      height: kDefaultPadding,
                    ),
                  ),
                );
              },
            ),
            ValueListenableBuilder(
              valueListenable: dropDownModel.isOpened,
              builder: (context, value, child) {
                return AnimatedContainer(
                  height: value ? 100 : 0,
                  duration: const Duration(milliseconds: 70),
                  child: Visibility(
                    visible: value,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: kDefaultPadding,
                        ),
                        ChartLabel(
                          participant: widget.participant,
                        ),
                        const Spacer(),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: ComparativeChart(
                            userData1: widget.meParticipant.inputData,
                          ),
                        ),
                        const SizedBox(
                          width: kDefaultPadding,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      );
    }
  }
}
