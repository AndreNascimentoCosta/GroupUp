import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/extensions/gp_navigator_extension.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/utils/icons/gp_icons.dart';
import 'package:groupup/core/widgets/icons/gp_icon.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';
import 'package:groupup/core/constants/design-system.dart';
import 'package:groupup/models/group_model.dart';
import 'package:groupup/models/home_view.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/modules/groups/components/groups_events.dart';
import 'package:groupup/modules/groups/components/stats_group_ongoing.dart';
import 'package:groupup/modules/individual_group/screens/individual_group.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GroupCard extends StatefulWidget {
  const GroupCard({
    Key? key,
    required this.group,
    required this.homeViewModel,
  }) : super(key: key);

  final GroupModel group;
  final HomeViewModel homeViewModel;

  @override
  State<GroupCard> createState() => _GroupCardState();
}

class _GroupCardState extends State<GroupCard> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final individualGroupProvider = Provider.of<IndividualGroupProvider>(
      context,
      listen: false,
    );
    final participantsSumValue = widget.group.participantsData.map((
      element,
    ) {
      return element.sumData.value;
    }).toList();
    participantsSumValue.sort(
      (a, b) => b.compareTo(a),
    );
    return ButtonCommonStyle(
      onPressed: () async {
        Provider.of<MixPanelProvider>(
          context,
          listen: false,
        ).logEvent(
          eventName: GroupsEvents.pressGroupCard.value,
        );
        individualGroupProvider.getGroup(
          widget.group.id,
        );
        Provider.of<AuthProvider>(
          context,
          listen: false,
        ).getUser();
        individualGroupProvider.isClaimingReward = false;
        individualGroupProvider.updateIndex(0);
        context.push(
          MaterialPageRoute(
            builder: (context) {
              return const IndividualGroupScreen();
            },
            settings: const RouteSettings(
              name: 'Individual_Group',
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(
                37.5,
              ),
              child: widget.group.image.isNotEmpty
                  ? Container(
                      height: Insets.l * 3.75,
                      width: Insets.l * 3.75,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            widget.group.image,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : const GPIcon(
                      GPIcons.profile2,
                      height: Insets.xl * 3,
                      width: Insets.xl * 3,
                    ),
            ),
            if (widget.group.endDate != null)
              Builder(
                builder: (context) {
                  bool groupEndedMoreThan1DayAgo =
                      widget.group.endDate!.isBefore(
                    DateTime.now().subtract(
                      const Duration(days: 1),
                    ),
                  );
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: kDefaultPadding,
                      ),
                      child: groupEndedMoreThan1DayAgo
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GPTextBody(
                                  text: Characters(
                                    widget.group.projectName,
                                  )
                                      .replaceAll(
                                        Characters(''),
                                        Characters(
                                          '\u{200B}',
                                        ),
                                      )
                                      .toString(),
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 16,
                                ),
                                const SizedBox(
                                  height: Insets.s,
                                ),
                                GPTextBody(
                                  text: AppLocalizations.of(
                                    context,
                                  )!
                                      .ended,
                                  color: GPColors.secondaryColor,
                                ),
                              ],
                            )
                          : GPTextBody(
                              text: Characters(
                                widget.group.projectName,
                              )
                                  .replaceAll(
                                    Characters(''),
                                    Characters(
                                      '\u{200B}',
                                    ),
                                  )
                                  .toString(),
                              overflow: TextOverflow.ellipsis,
                              fontSize: 16,
                            ),
                    ),
                  );
                },
              ),
            StatsGroup(
              group: widget.group,
              homeViewModel: widget.homeViewModel,
            ),
          ],
        ),
      ),
    );
  }
}
