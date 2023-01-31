import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/widgets/texts/medium_body.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/group_model.dart';
import 'package:groupup/models/home_view.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';

class StatsGroup extends StatelessWidget {
  const StatsGroup({
    Key? key,
    required this.group,
    required this.homeViewModel,
  }) : super(key: key);

  final GroupModel group;
  final HomeViewModel homeViewModel;

  @override
  Widget build(BuildContext context) {
    final currentUserId = Provider.of<AuthProvider>(context).user?.id;
    final currentUserRank = group.currentParticipant(currentUserId ?? '').rank(group);
    return ValueListenableBuilder(
      valueListenable: homeViewModel.isEditing,
      builder: (context, value, child) {
        return AnimatedContainer(
          width: !value ? 80 : 0,
          duration: const Duration(milliseconds: 50),
          child: Visibility(
            visible: !value,
            child: Row(
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding,
                    ),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/rank.svg',
                          height: Insets.l,
                          width: Insets.l,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          height: kDefaultPadding * 0.25,
                        ),
                        SvgPicture.asset(
                          'assets/icons/daysgone.svg',
                          height: Insets.l,
                          width: Insets.l,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          height: kDefaultPadding * 0.25,
                        ),
                        SvgPicture.asset(
                          'assets/icons/daysleft.svg',
                          height: Insets.l,
                          width: Insets.l,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
                if (group.endDate != null)
                  SizedBox(
                    width: Insets.l,
                    child: group.endDate!.isBefore(DateTime.now())
                        ? Column(
                            children: [
                              MediumBody(
                                text: currentUserRank,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: kDefaultPadding * 0.25,
                              ),
                              const MediumBody(
                                text: '-',
                                textAlign: TextAlign.center,
                                color: Colors.red,
                              ),
                              const SizedBox(
                                height: kDefaultPadding * 0.25,
                              ),
                              const MediumBody(
                                text: '-',
                                textAlign: TextAlign.center,
                                color: kPrimaryColor,
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              MediumBody(
                                text: currentUserRank,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: kDefaultPadding * 0.25,
                              ),
                              MediumBody(
                                text: group.daysGone,
                                textAlign: TextAlign.center,
                                color: Colors.red,
                              ),
                              const SizedBox(
                                height: kDefaultPadding * 0.25,
                              ),
                              MediumBody(
                                text: group.daysLeft,
                                textAlign: TextAlign.center,
                                color: kPrimaryColor,
                              ),
                            ],
                          ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
