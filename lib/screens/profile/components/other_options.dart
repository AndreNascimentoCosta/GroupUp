import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/large_body.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/screens/home/components/bottom_sheet/sign_up/auth_provider.dart';
import 'package:groupup/screens/profile/components/alert_dialog_delete.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
            onPressed: () {},
            child: const LargeBody(
              text: 'Privacy policy',
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: Insets.l * 1.5),
          ButtonCommonStyle(
            onPressed: () {
              Navigator.pop(context);
              confirmDelete(context);
            },
            child: const LargeBody(
              text: 'Delete account',
              textAlign: TextAlign.center,
              color: Colors.black,
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
          ),
        ],
      ),
    );
  }
  _launchURL() async {
  const url = 'https://flutter.io';
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    throw 'Could not launch $url';
  }
}
}
