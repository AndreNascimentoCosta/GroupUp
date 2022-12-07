import 'package:flutter/material.dart';

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
      items: const [
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(top: kDefaultPadding * 0.5),
            child: Text(
              'Archive',
              style: TextStyle(
                fontFamily: 'Montserrat-Semibold',
                fontSize: 18,
                color: kGroupEditColor,
              ),
            ),
          ),
          activeIcon: Padding(
            padding: EdgeInsets.only(top: kDefaultPadding * 0.5),
            child: Text(
              'Archive',
              style: TextStyle(
                fontFamily: 'Montserrat-Semibold',
                fontSize: 18,
                color: kPrimaryColor,
              ),
            ),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(top: kDefaultPadding * 0.5),
            child: Text(
              'Pin',
              style: TextStyle(
                fontFamily: 'Montserrat-Semibold',
                fontSize: 18,
                color: kGroupEditColor,
              ),
            ),
          ),
          activeIcon: Padding(
            padding: EdgeInsets.only(top: kDefaultPadding * 0.5),
            child: Text(
              'Pin',
              style: TextStyle(
                fontFamily: 'Montserrat-Semibold',
                fontSize: 18,
                color: kPrimaryColor,
              ),
            ),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(top: kDefaultPadding * 0.5),
            child: Text(
              'Delete',
              style: TextStyle(
                fontFamily: 'Montserrat-Semibold',
                fontSize: 18,
                color: kGroupEditColor,
              ),
            ),
          ),
          activeIcon: Padding(
            padding: EdgeInsets.only(top: kDefaultPadding * 0.5),
            child: Text(
              'Delete',
              style: TextStyle(
                fontFamily: 'Montserrat-Semibold',
                fontSize: 18,
                color: kPrimaryColor,
              ),
            ),
          ),
          label: '',
        ),
      ],
    );
  }
}
