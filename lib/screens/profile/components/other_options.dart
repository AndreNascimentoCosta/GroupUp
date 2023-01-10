import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/large_body.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/screens/home/components/bottom_sheet/sign_up/auth_provider.dart';
import 'package:provider/provider.dart';

class OtherOptionsProfile extends StatelessWidget {
  const OtherOptionsProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
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
              Navigator.pop(context);
              authProvider.signOut();
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
