import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/core/widgets/texts/medium_body.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/group.dart';
import 'package:groupup/models/home_view.dart';
import '../../../constants.dart';

class StatsGroup extends StatelessWidget {
  const StatsGroup(
      {Key? key,
      required this.groupModel,
      required this.homeViewModel})
      : super(key: key);

  final GroupModel groupModel;
  final HomeViewModel homeViewModel;

  @override
  Widget build(BuildContext context) {
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
                SizedBox(
                  width: Insets.l,
                  child: Column(
                    children: [
                      MediumBody(
                        text: groupModel.rank,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: kDefaultPadding * 0.25,
                      ),
                      MediumBody(
                        text: groupModel.daysGone,
                        textAlign: TextAlign.center,
                        color: Colors.red,
                      ),
                      const SizedBox(
                        height: kDefaultPadding * 0.25,
                      ),
                      MediumBody(
                        text: groupModel.daysLeft,
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
