import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/large_body.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/home/screens/home.dart';
import 'package:groupup/core/widgets/buttons/button.dart';

class OtherOptionsProfile extends StatelessWidget {
  const OtherOptionsProfile({super.key});

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
            child: const LargeBody(
              text: 'Terms of service',
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: Insets.l * 1.5),
          ButtonCommonStyle(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: ((context) => Home())),
                  (route) => false);
            },
            child: const LargeBody(
              text: 'Log out',
              textAlign: TextAlign.center,
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}
