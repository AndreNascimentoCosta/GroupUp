import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/screens/home/screens/home.dart';

class AppBarOnboarding extends StatelessWidget with PreferredSizeWidget {
  const AppBarOnboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: 100,
            child: ButtonCommonStyle(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const Home(),
                    ),
                    (route) => false);
              },
              child: const StaticText(
                text: 'Skip',
                fontSize: TextSize.lBody,
                fontFamily: 'Montserrat-SemiBold',
                color: kSecondaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kAppBarHeight);
}
