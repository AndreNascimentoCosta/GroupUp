import 'package:flutter/material.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/group.dart';
import 'package:groupup/models/home_view.dart';
import 'package:groupup/styles/text.dart';
import '../../../constants.dart';

class StatsGroup extends StatelessWidget {
  const StatsGroup(
      {Key? key,
      required this.groupModel,
      required this.press,
      required this.homeViewModel})
      : super(key: key);

  final GroupModel groupModel;
  final VoidCallback press;
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
                        ImageIcon(
                          AssetImage(
                            groupModel.rankIcon,
                          ),
                          size: kDefaultPadding,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          height: kDefaultPadding * 0.25,
                        ),
                        ImageIcon(
                          AssetImage(
                            groupModel.daysGoneIcon,
                          ),
                          size: kDefaultPadding,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          height: kDefaultPadding * 0.25,
                        ),
                        ImageIcon(
                          AssetImage(
                            groupModel.daysLeftIcon,
                          ),
                          size: kDefaultPadding,
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
                      StandardTextStyle(
                        text: groupModel.rank,
                        textAlign: TextAlign.center,
                        fontSize: TextSize.mBody,
                      ),
                      const SizedBox(
                        height: kDefaultPadding * 0.25,
                      ),
                      StandardTextStyle(
                        text: groupModel.daysGone,
                        textAlign: TextAlign.center,
                        fontSize: TextSize.mBody,
                        color: Colors.red,
                      ),
                      const SizedBox(
                        height: kDefaultPadding * 0.25,
                      ),
                      StandardTextStyle(
                        text: groupModel.daysLeft,
                        textAlign: TextAlign.center,
                        fontSize: TextSize.mBody,
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
