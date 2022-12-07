import 'package:flutter/material.dart';

import '../../../constants.dart';

class BottomNavyBar extends StatefulWidget {
  BottomNavyBar({required this.pageController});

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
            child: ImageIcon(
              AssetImage(
                'assets/icons/home.png',
              ),
              size: 30,
            ),
          ),
          activeIcon: Padding(
            padding: EdgeInsets.only(top: kDefaultPadding * 0.5),
            child: ImageIcon(
              AssetImage(
                'assets/icons/home_selected.png',
              ),
              size: 30,
            ),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(top: kDefaultPadding * 0.5),
            child: ImageIcon(
              AssetImage(
                'assets/icons/profile.png',
              ),
              size: 30,
            ),
          ),
          activeIcon: Padding(
            padding: EdgeInsets.only(top: kDefaultPadding * 0.5),
            child: ImageIcon(
              AssetImage(
                'assets/icons/profile_selected.png',
              ),
              size: 30,
            ),
          ),
          label: '',
        ),
      ],
    );
  }
}
