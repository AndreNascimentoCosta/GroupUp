import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/screens/profile/components/appbarprofile.dart';

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
            MaterialButton(
              onPressed: () {},
              child: EditProfile(),
            ),
            const SizedBox(
              height: kDefaultPadding * 2.5,
            ),
            InkWell(
              onTap: () {},
              child: Row(
                children: const [
                  Text(
                    'Balance',
                    style: TextStyle(
                      fontFamily: 'Montserrat-Medium',
                      fontSize: 18,
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(right: kDefaultPadding),
                    child: Text(
                      '\$ 14.60',
                      style: TextStyle(
                        fontFamily: 'Montserrat-Medium',
                        fontSize: 18,
                      ),
                    ),
                  ),
                  ImageIcon(
                    AssetImage(
                      'assets/icons/arrow_right.png',
                    ),
                    size: kDefaultPadding,
                    color: Color(0xFFC3C3C3),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: kDefaultPadding * 2,
            ),
            InkWell(
              onTap: () {},
              child: Row(
                children: const [
                  Text(
                    'Refund requests',
                    style: TextStyle(
                      fontFamily: 'Montserrat-Medium',
                      fontSize: 18,
                    ),
                  ),
                  Spacer(),
                  ImageIcon(
                    AssetImage(
                      'assets/icons/arrow_right.png',
                    ),
                    size: kDefaultPadding,
                    color: Color(0xFFC3C3C3),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: kDefaultPadding * 2,
            ),
            InkWell(
              onTap: () {},
              child: Row(
                children: const [
                  Text(
                    'Created groups',
                    style: TextStyle(
                      fontFamily: 'Montserrat-Medium',
                      fontSize: 18,
                    ),
                  ),
                  Spacer(),
                  ImageIcon(
                    AssetImage(
                      'assets/icons/arrow_right.png',
                    ),
                    size: kDefaultPadding,
                    color: Color(0xFFC3C3C3),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
