import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/constants/design_system.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/utils/icons/gp_icons.dart';
import 'package:groupup/core/widgets/icons/gp_icon.dart';
import 'package:provider/provider.dart';

class GPBottomNavigationBar extends StatefulWidget {
  const GPBottomNavigationBar({required this.pageController});

  final PageController pageController;

  @override
  State<GPBottomNavigationBar> createState() => _GPBottomNavigationBarState();
}

class _GPBottomNavigationBarState extends State<GPBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: GPColors.white,
      selectedFontSize: 0,
      unselectedFontSize: 0,
      currentIndex: widget.pageController.page?.round() ?? 0,
      selectedItemColor: GPColors.primaryColor,
      unselectedItemColor: GPColors.secondaryColor,
      onTap: (value) => setState(
        () {
          Provider.of<AuthProvider>(
            context,
            listen: false,
          ).getUser();
          widget.pageController.jumpToPage(
            value,
          );
        },
      ),
      items: const [
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(
              top: kDefaultPadding * 0.5,
            ),
            child: GPIcon(
              GPIcons.home,
              height: Insets.l * 1.5,
              width: Insets.l * 1.5,
            ),
          ),
          activeIcon: Padding(
            padding: EdgeInsets.only(
              top: kDefaultPadding * 0.5,
            ),
            child: GPIcon(
              GPIcons.homeSelected,
              height: Insets.l * 1.5,
              width: Insets.l * 1.5,
            ),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(
              top: kDefaultPadding * 0.5,
            ),
            child: GPIcon(
              GPIcons.profile,
              height: Insets.l * 1.5,
              width: Insets.l * 1.5,
            ),
          ),
          activeIcon: Padding(
            padding: EdgeInsets.only(
              top: kDefaultPadding * 0.5,
            ),
            child: GPIcon(
              GPIcons.profileSelected,
              height: Insets.l * 1.5,
              width: Insets.l * 1.5,
            ),
          ),
          label: '',
        ),
      ],
    );
  }
}
