import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/extensions/gp_navigator_extension.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/utils/icons/gp_icons.dart';
import 'package:groupup/core/widgets/icons/gp_icon.dart';
import 'package:groupup/core/constants/design-system.dart';
import 'package:groupup/core/widgets/loading/gp_loading.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';
import 'package:groupup/core/widgets/texts/gp_text_header.dart';
import 'package:groupup/models/dropdown_model.dart';
import 'package:groupup/models/participant_model.dart';
import 'package:groupup/modules/individual_group/components/chart/comparative_chart.dart';
import 'package:groupup/modules/individual_group/components/chart/label.dart';
import 'package:groupup/modules/individual_group/components/individual_value.dart';
import 'package:groupup/models/home_view_model.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/modules/individual_group/components/story_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/providers/auth_provider.dart';
import '../../../core/providers/mix_panel_provider.dart';

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
    final appLocalizations = AppLocalizations.of(context)!;
    if (individualGroupProvider.group == null) {
      return const GPLoading();
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
                      child: SizedBox(
                        width: context.screenWidth * 0.075,
                        child: GPTextBody(
                          text: widget.participant.rank(
                            individualGroupProvider.group,
                          ),
                          textAlign: widget.participant.rank(
                                    individualGroupProvider.group,
                                  ) ==
                                  '-'
                              ? TextAlign.center
                              : TextAlign.start,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: context.screenWidth * 0.01,
                    ),
                    ButtonCommonStyle(
                      onPressed: () {
                        Provider.of<MixPanelProvider>(
                          context,
                          listen: false,
                        ).logEvent(
                          eventName: 'Individual Group - Profile Picture',
                        );
                        if (widget.participant.hasStory) {
                          context.pushCupertino(
                            StoryPage(
                              inputDatas: widget.participant.inputData,
                              participant: widget.participant,
                            ),
                          );
                        }
                      },
                      child: widget.participant.profilePicture.isNotEmpty
                          ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  Insets.l * 6,
                                ),
                                color: widget.participant.hasStory
                                    ? GPColors.primaryColor
                                    : GPColors.transparent,
                              ),
                              padding: widget.participant.hasStory
                                  ? const EdgeInsets.all(3)
                                  : EdgeInsets.zero,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  widget.participant.hasStory
                                      ? Insets.l * 3
                                      : Insets.l * 3.45,
                                ),
                                child: Container(
                                  height: widget.participant.hasStory
                                      ? Insets.l * 3
                                      : Insets.l * 3.45,
                                  width: widget.participant.hasStory
                                      ? Insets.l * 3
                                      : Insets.l * 3.45,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                        widget.participant.profilePicture,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  Insets.l * 6,
                                ),
                                color: widget.participant.hasStory
                                    ? GPColors.primaryColor
                                    : GPColors.transparent,
                              ),
                              padding: const EdgeInsets.all(3),
                              child: CircleAvatar(
                                radius: widget.participant.hasStory
                                    ? Insets.l * 1.50
                                    : Insets.l * 1.65,
                                backgroundColor: const Color(
                                  0XFFE1E1E1,
                                ),
                                child: GPIcon(
                                  GPIcons.profilePictureAdd,
                                  color: GPColors.white,
                                  height: widget.participant.hasStory
                                      ? Insets.l * 1.50
                                      : Insets.l * 1.65,
                                  width: widget.participant.hasStory
                                      ? Insets.l * 1.50
                                      : Insets.l * 1.65,
                                ),
                              ),
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
                                      ? Padding(
                                          padding: EdgeInsets.only(
                                            left: context.screenWidth * 0.02,
                                          ),
                                          child: GPTextHeader(
                                            text: appLocalizations.me,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )
                                      : Padding(
                                          padding: EdgeInsets.only(
                                            left: context.screenWidth * 0.02,
                                          ),
                                          child: GPTextHeader(
                                            text: Characters(
                                              widget.participant.name,
                                            )
                                                .replaceAll(
                                                  Characters(''),
                                                  Characters('\u{200B}'),
                                                )
                                                .toString(),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )
                                  : const GPTextHeader(text: ''),
                            ),
                            const SizedBox(
                              width: kDefaultPadding / 4,
                            ),
                            IndividualValue(
                              homeViewModel: widget.homeViewModel,
                              userInputData: widget.participant.sumData,
                              dropDownModel: dropDownModel,
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
                  duration: const Duration(
                    milliseconds: 150,
                  ),
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
                  duration: const Duration(
                    milliseconds: 70,
                  ),
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
                          width: context.screenWidth * 0.6,
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
