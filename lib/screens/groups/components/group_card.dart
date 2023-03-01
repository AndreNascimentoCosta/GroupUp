import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/core/widgets/texts/medium_body.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/group_model.dart';
import 'package:groupup/models/home_view.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/screens/groups/components/checkbox.dart';
import 'package:groupup/screens/groups/components/stats_group_ongoing.dart';
import 'package:groupup/screens/individual_group/screens/individual_group.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/providers/mix_panel_provider.dart';

class GroupsCard extends StatefulWidget {
  const GroupsCard({
    Key? key,
    required this.group,
    required this.homeViewModel,
  }) : super(key: key);

  final GroupModel group;
  final HomeViewModel homeViewModel;

  @override
  State<GroupsCard> createState() => _GroupsCardState();
}

class _GroupsCardState extends State<GroupsCard> {
  bool isChecked = false;
  final CheckBoxGroup checkBoxGroup = CheckBoxGroup();

  @override
  Widget build(BuildContext context) {
    final individualGroupProvider =
        Provider.of<IndividualGroupProvider>(context, listen: false);
    final participantsSumValue = widget.group.participantsData.map((element) {
      return element.sumData.value;
    }).toList();
    participantsSumValue.sort((a, b) => b.compareTo(a));
    return ButtonCommonStyle(
      onPressed: () async {
        if (widget.homeViewModel.isEditing.value) {
          setState(
            () {
              isChecked = !isChecked;
            },
          );
        } else {
          Provider.of<MixPanelProvider>(context, listen: false)
              .logEvent(eventName: 'Individual Group Screen');
          individualGroupProvider.getGroup(
            widget.group.id,
          );
          Provider.of<AuthProvider>(context, listen: false).getUser();
          individualGroupProvider.isClaimingReward = false;
          individualGroupProvider.updateIndex(0);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const IndividualGroupScreen();
              },
              settings: const RouteSettings(name: 'Individual_Group'),
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Row(
          children: [
            ValueListenableBuilder(
              valueListenable: widget.homeViewModel.isEditing,
              builder: (context, value, child) {
                return AnimatedContainer(
                  width: value ? 50 : 0,
                  duration: const Duration(milliseconds: 50),
                  child: Visibility(
                    visible: value,
                    child: CheckBoxGroup(
                      isChecked: isChecked,
                    ),
                  ),
                );
              },
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(37.5),
              child: widget.group.image.isNotEmpty
                  ? Image.network(
                      widget.group.image,
                      height: 75,
                      width: 75,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/icons/profile2.png',
                      height: 75,
                      width: 75,
                    ),
            ),
            if (widget.group.endDate != null)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: kDefaultPadding,
                  ),
                  child: participantsSumValue.length > 1 &&
                          participantsSumValue
                                  .where((element) =>
                                      element == participantsSumValue.first)
                                  .length >
                              1
                      ? widget.group.endDate!.isBefore(
                          DateTime.now().subtract(
                            const Duration(days: 3),
                          ),
                        )
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                StaticText(
                                  text: Characters(widget.group.projectName)
                                      .replaceAll(
                                        Characters(''),
                                        Characters('\u{200B}'),
                                      )
                                      .toString(),
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 20,
                                ),
                                const SizedBox(height: Insets.s),
                                MediumBody(
                                  text: AppLocalizations.of(context).ended,
                                  color: kSecondaryColor,
                                ),
                              ],
                            )
                          : StaticText(
                              text: Characters(widget.group.projectName)
                                  .replaceAll(
                                    Characters(''),
                                    Characters('\u{200B}'),
                                  )
                                  .toString(),
                              overflow: TextOverflow.ellipsis,
                              fontSize: 20,
                            )
                      : widget.group.endDate!.isBefore(
                          DateTime.now().subtract(
                            const Duration(days: 1),
                          ),
                        )
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                StaticText(
                                  text: Characters(widget.group.projectName)
                                      .replaceAll(
                                        Characters(''),
                                        Characters('\u{200B}'),
                                      )
                                      .toString(),
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 20,
                                ),
                                const SizedBox(height: Insets.s),
                                MediumBody(
                                  text: AppLocalizations.of(context).ended,
                                  color: kSecondaryColor,
                                ),
                              ],
                            )
                          : StaticText(
                              text: Characters(widget.group.projectName)
                                  .replaceAll(
                                    Characters(''),
                                    Characters('\u{200B}'),
                                  )
                                  .toString(),
                              overflow: TextOverflow.ellipsis,
                              fontSize: 20,
                            ),
                ),
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
