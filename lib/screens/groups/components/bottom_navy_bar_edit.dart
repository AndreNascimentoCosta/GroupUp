import 'package:flutter/material.dart';
import 'package:groupup/styles/standard_text.dart';
import '../../../constants.dart';

class BottomNavyBarEdit extends StatefulWidget {
  const BottomNavyBarEdit({super.key});

  @override
  State<BottomNavyBarEdit> createState() => _BottomNavyBarEditState();
}

class _BottomNavyBarEditState extends State<BottomNavyBarEdit> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedFontSize: 0,
      unselectedFontSize: 0,
      currentIndex: _selectedIndex,
      selectedItemColor: kPrimaryColor,
      unselectedItemColor: kSecondaryColor,
      onTap: (value) {
        setState(() {
          _selectedIndex = value;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.only(top: kDefaultPadding * 0.5),
            child: StandardTextStyle(
              text: 'Archive',
              fontSize: 18,
              color: kGroupEditColor,
            ),
          ),
          activeIcon: Padding(
            padding: const EdgeInsets.only(top: kDefaultPadding * 0.5),
            child: StandardTextStyle(
              text: 'Archive',
              fontSize: 18,
              color: kPrimaryColor,
            ),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.only(top: kDefaultPadding * 0.5),
            child: StandardTextStyle(
              text: 'Pin',
              fontSize: 18,
              color: kGroupEditColor,
            ),
          ),
          activeIcon: Padding(
            padding: const EdgeInsets.only(top: kDefaultPadding * 0.5),
            child: StandardTextStyle(
              text: 'Pin',
              fontSize: 18,
              color: kPrimaryColor,
            ),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: const EdgeInsets.only(top: kDefaultPadding * 0.5),
            child: StandardTextStyle(
              text: 'Delete',
              fontSize: 18,
              color: kGroupEditColor,
            ),
          ),
          activeIcon: Padding(
            padding: const EdgeInsets.only(top: kDefaultPadding * 0.5),
            child: StandardTextStyle(
              text: 'Delete',
              fontSize: 18,
              color: kPrimaryColor,
            ),
          ),
          label: '',
        ),
      ],
    );
  }
}
