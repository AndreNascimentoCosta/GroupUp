import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/header.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/group.dart';
import 'package:groupup/screens/balance/screens/balance.dart';
import 'package:groupup/screens/created_groups/screens/created_groups_screen.dart';
import 'package:groupup/screens/edit_profile/screens/edit_profile.dart';
import 'package:groupup/screens/refund_requests/screens/refund_requests.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/screens/profile/components/app_bar.dart';
import 'package:groupup/screens/profile/components/body_button.dart';

import 'edit_profile_button.dart';

class BodyProfile extends StatelessWidget {
  BodyProfile({super.key});

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
            const SizedBox(height: kDefaultPadding),
            CircleAvatar(
              radius: 70,
              backgroundColor: const Color(0XFFE1E1E1),
              child: SvgPicture.asset(
                'assets/icons/profile_picture.svg',
                color: Colors.white,
                height: Insets.l * 3,
                width: Insets.l * 3,
              ),
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            const Header(
              text: 'Angus MacGyver',
              textAlign: TextAlign.center,
              fontFamily: 'Montserrat-SemiBold',
            ),
            const SizedBox(height: kDefaultPadding * 1.25),
            ButtonCommonStyle(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EditProfileScreen()));
              },
              child: const EditProfile(),
            ),
            const SizedBox(height: kDefaultPadding * 2.5),
            BodyButtonModel(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BalanceScreen(groupsData: groupsData,),
                      ));
                },
                text: 'Balance',
                secondaryText: '\$ 14.60'),
            const SizedBox(height: kDefaultPadding * 2),
            BodyButtonModel(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RefundRequestsScreen(groupsData: groupsData,),
                      ));
                },
                text: 'Refund requests',
                secondaryText: ''),
            const SizedBox(height: kDefaultPadding * 2),
            BodyButtonModel(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreatedGroupsScreen(groupsData: groupsData,),
                      ));
                },
                text: 'Created groups',
                secondaryText: '')
          ],
        ),
      ),
    );
  }

  final List<GroupModel> groupsData = [];

}
