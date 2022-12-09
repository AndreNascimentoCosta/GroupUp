import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/styles/button_style.dart';
import 'package:groupup/screens/profile/components/appbarprofile.dart';
import 'package:groupup/screens/profile/models/body_button.dart';

import 'edit_profile_button.dart';

class BodyProfile extends StatelessWidget {
  const BodyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarProfile(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: kDefaultPadding,
            ),
            const CircleAvatar(
              radius: 70,
              backgroundColor: Color(0XFFE1E1E1),
              child: ImageIcon(
                AssetImage(
                  'assets/icons/profile_picture.png',
                ),
                color: Colors.white,
                size: 60,
              ),
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            const Text(
              'Angus MacGyver',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Montserrat-SemiBold',
                fontSize: 24,
              ),
            ),
            const SizedBox(
              height: kDefaultPadding * 1.25,
            ),
            ButtonCommonStyle(
              onPressed: () {},
              child: EditProfile(),
            ),
            const SizedBox(
              height: kDefaultPadding * 2.5,
            ),
            BodyButtonModel(
              onPressed: () {},
              text: 'Balance',
              secondaryText: '\$ 14.60',
            ),
            const SizedBox(
              height: kDefaultPadding * 2,
            ),
            BodyButtonModel(
              onPressed: () {},
              text: 'Refund requests',
              secondaryText: '',
            ),
            const SizedBox(
              height: kDefaultPadding * 2,
            ),
            BodyButtonModel(
              onPressed: () {},
              text: 'Created groups',
              secondaryText: '',
            )
          ],
        ),
      ),
    );
  }
}
