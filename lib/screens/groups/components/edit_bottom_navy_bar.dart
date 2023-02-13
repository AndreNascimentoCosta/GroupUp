import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/widgets/texts/large_body.dart';
import '../../../constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BottomNavyBarEdit extends StatefulWidget {
  const BottomNavyBarEdit({super.key});

  @override
  State<BottomNavyBarEdit> createState() => _BottomNavyBarEditState();
}

class _BottomNavyBarEditState extends State<BottomNavyBarEdit> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('groups').snapshots(),
      builder: ((context, snapshot) {
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
              icon: ButtonCommonStyle(
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.only(top: kDefaultPadding * 0.5),
                  child: LargeBody(
                    text: AppLocalizations.of(context).pin,
                    color: kGroupEditColor,
                  ),
                ),
              ),
              activeIcon: Padding(
                padding: const EdgeInsets.only(top: kDefaultPadding * 0.5),
                child: LargeBody(
                  text: AppLocalizations.of(context).pin,
                  color: kPrimaryColor,
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: ButtonCommonStyle(
                onPressed: () {

                },
                child: Padding(
                  padding: const EdgeInsets.only(top: kDefaultPadding * 0.5),
                  child: LargeBody(
                    text: AppLocalizations.of(context).delete,
                    color: kGroupEditColor,
                  ),
                ),
              ),
              activeIcon: Padding(
                padding: const EdgeInsets.only(top: kDefaultPadding * 0.5),
                child: LargeBody(
                  text: AppLocalizations.of(context).delete,
                  color: kPrimaryColor,
                ),
              ),
              label: '',
            ),
          ],
        );
      }),
    );
  }
}
