import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/home/screens/home.dart';
import 'package:groupup/styles/button.dart';
import 'package:groupup/styles/text.dart';

class OthersProfile extends StatelessWidget {
  const OthersProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding * 1.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ButtonCommonStyle(
            onPressed: () {},
            child: const StandardTextStyle(
              text: 'Terms of service',
              textAlign: TextAlign.center,
              fontSize: TextSize.lBody,
            ),
          ),
          const SizedBox(height: Insets.l * 1.5),
          ButtonCommonStyle(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: ((context) => Home())),
                  (route) => false);
            },
            child: const StandardTextStyle(
              text: 'Log out',
              textAlign: TextAlign.center,
              fontFamily: 'Montserrat-SemiBold',
              fontSize: TextSize.lBody,
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}
