import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/large_body.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/home/components/bottom_sheet/create/button.dart';
import 'package:groupup/screens/home/components/bottom_sheet/join/button.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
              right: kDefaultPadding * 1.5, left: kDefaultPadding * 1.5),
          child: ListView(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: Insets.l),
                const StaticText(
                  text: 'GroupUp',
                  fontSize: 36,
                  fontFamily: 'Montserrat-Bold',
                ),
                const SizedBox(height: Insets.s),
                const LargeBody(
                  text: 'Create or join a group and start setting your goals!',
                  maxLines: 2,
                  letterSpacing: 1,
                ),
                const SizedBox(height: Insets.l * 1.5),
                SvgPicture.asset(
                  'assets/images/target_team.svg',
                  height: MediaQuery.of(context).size.height * 0.45,
                  fit: BoxFit.fitHeight,
                ),
                const SizedBox(height: Insets.l * 2),
                const JoinGroupButton(),
                const SizedBox(height: Insets.l),
                const CreateGroupButton(),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
