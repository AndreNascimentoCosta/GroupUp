import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/screens/edit_profile/screens/edit_profile_screen.dart';
import 'package:groupup/styles/button_style.dart';
import 'package:groupup/styles/standard_text.dart';

class AppBarBalance extends StatelessWidget with PreferredSizeWidget {
  const AppBarBalance({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.centerStart,
            children: [
              Container(
                width: 390,
                height: 50,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 0.2,
                      color: Color(0xffa1a1a1),
                    ),
                  ),
                ),
                alignment: AlignmentDirectional.center,
                child: StandardTextStyle(
                  text: 'Balance',
                  fontFamily: 'Montserrat-Bold',
                  fontSize: 24,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: kDefaultPadding),
                child: ButtonCommonStyle(
                  child: const ImageIcon(
                    AssetImage(
                      'assets/icons/arrow_left.png',
                    ),
                    size: kDefaultPadding * 1.25,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pop(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditProfileScreen(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
