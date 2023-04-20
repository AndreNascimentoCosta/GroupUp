import 'package:flutter/material.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/screens/groups/components/icon_bottom_navy_bar.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/constants.dart';

class BottomNavyBar extends StatefulWidget {
  const BottomNavyBar({required this.pageController});

  final PageController pageController;

  @override
  State<BottomNavyBar> createState() => _BottomNavyBarState();
}

class _BottomNavyBarState extends State<BottomNavyBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: GPColors.white,
      selectedFontSize: 0,
      unselectedFontSize: 0,
      currentIndex: widget.pageController.page?.round() ?? 0,
      selectedItemColor: GPColors.primaryColor,
      unselectedItemColor: GPColors.secondaryColor,
      onTap: (value) => setState(() {
        Provider.of<AuthProvider>(context, listen: false).getUser();
        widget.pageController.jumpToPage(value);
      },),
      items: const [
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(top: kDefaultPadding * 0.5),
            child: IconBottonNavyBarModel(
              imageIcon: 'assets/icons/home.svg',
            ),
          ),
          activeIcon: Padding(
            padding: EdgeInsets.only(top: kDefaultPadding * 0.5),
            child: IconBottonNavyBarModel(
              imageIcon: 'assets/icons/home_selected.svg',
            ),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(top: kDefaultPadding * 0.5),
            child: IconBottonNavyBarModel(
              imageIcon: 'assets/icons/profile.svg',
            ),
          ),
          activeIcon: Padding(
            padding: EdgeInsets.only(top: kDefaultPadding * 0.5),
            child: IconBottonNavyBarModel(
              imageIcon: 'assets/icons/profile_selected.svg',
            ),
          ),
          label: '',
        ),
      ],
    );
  }
}
