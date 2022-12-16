import 'package:flutter/material.dart';
import 'package:groupup/screens/groups/models/icon_bottom_navy_bar.dart';
import '../../../constants.dart';

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
      backgroundColor: Colors.white,
      selectedFontSize: 0,
      unselectedFontSize: 0,
      currentIndex: widget.pageController.page?.round() ?? 0,
      selectedItemColor: kPrimaryColor,
      unselectedItemColor: kSecondaryColor,
      onTap: (value) => setState(() {
        widget.pageController.jumpToPage(value);
      }),
      items: const [
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(top: kDefaultPadding * 0.5),
            child: IconBottonNavyBarModel(
              imageIcon: 'assets/icons/home.png',
            ),
          ),
          activeIcon: Padding(
            padding: EdgeInsets.only(top: kDefaultPadding * 0.5),
            child: IconBottonNavyBarModel(
              imageIcon: 'assets/icons/home_selected.png',
            ),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(top: kDefaultPadding * 0.5),
            child: IconBottonNavyBarModel(
              imageIcon: 'assets/icons/profile.png',
            ),
          ),
          activeIcon: Padding(
            padding: EdgeInsets.only(top: kDefaultPadding * 0.5),
            child: IconBottonNavyBarModel(
              imageIcon: 'assets/icons/profile_selected.png',
            ),
          ),
          label: '',
        ),
      ],
    );
  }
}
