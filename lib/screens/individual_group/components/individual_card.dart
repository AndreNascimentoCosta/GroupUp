import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
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
import 'package:groupup/screens/individual_group/components/story_page.dart';
import 'package:provider/provider.dart';

import '../../../core/providers/auth_provider.dart';

class IndividualGroupCard extends StatefulWidget {
  const IndividualGroupCard({
    Key? key,
    required this.participant,
    required this.homeViewModel,
  }) : super(key: key);

  final Participant participant;
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
    if (individualGroupProvider.group == null) {
      return const CircularProgressIndicator(color: kPrimaryColor);
    } else {
      final authProvider = Provider.of<AuthProvider>(context);
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Column(
          children: [
            ValueListenableBuilder(
              valueListenable: widget.homeViewModel.isEditing,
              builder: (context, value, child) {
                return Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: kDefaultPadding / 2,
                      ),
                      child: ExtraLargeBody(
                          text: widget.participant.rank(context)),
                    ),
                    const SizedBox(width: kDefaultPadding),
                    widget.participant.profilePicture.isNotEmpty
                        ? ButtonCommonStyle(
                            onPressed: () {
                              if (widget.participant.hasStory) {
                                Navigator.of(context).push(
                                  CupertinoPageRoute(
                                    builder: (context) => StoryPage(
                                      inputDatas: widget.participant.inputData,
                                      participant: widget.participant,
                                    ),
                                    fullscreenDialog: true,
                                  ),
                                );
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Insets.l * 6),
                                color: widget.participant.hasStory
                                    ? kPrimaryColor
                                    : Colors.transparent,
                              ),
                              padding: const EdgeInsets.all(3),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(Insets.l * 6),
                                child: CachedNetworkImage(
                                  imageUrl: widget.participant.profilePicture,
                                  fadeInDuration:
                                      const Duration(milliseconds: 100),
                                  height: Insets.l * 3,
                                  width: Insets.l * 3,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                        : CircleAvatar(
                            radius: Insets.l * 1.65,
                            backgroundColor: const Color(0XFFE1E1E1),
                            child: SvgPicture.asset(
                              'assets/icons/profile_picture_add.svg',
                              color: Colors.white,
                              height: Insets.l * 1.65,
                              width: Insets.l * 1.65,
                            ),
                          ),
                    Expanded(
                      child: ButtonCommonStyle(
                        onPressed: dropDownModel.switchEdit,
                        child: Row(
                          children: [
                            Expanded(
                              child: authProvider.user != null
                                  ? authProvider.user!.id ==
                                          widget.participant.uid
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
                                            text: Characters(
                                                    widget.participant.name)
                                                .replaceAll(Characters(''),
                                                    Characters('\u{200B}'))
                                                .toString(),
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 20,
                                          ),
                                        )
                                  : const StaticText(text: ''),
                            ),
                            const SizedBox(width: kDefaultPadding / 4),
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
                      ),
                    ),
                  ],
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
                            userData1: widget.participant.inputData,
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
