import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/home/models/create_group_button.dart';
import 'package:groupup/screens/home/models/join_group_button.dart';
import 'package:groupup/styles/text.dart';

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
                const StandardTextStyle(
                  text: 'GroupUp',
                  textAlign: TextAlign.left,
                  fontFamily: 'Montserrat-Bold',
                  fontWeight: FontWeight.bold,
                  fontSize: TextSize.title,
                ),
                const SizedBox(height: Insets.s),
                const Text(
                  'Create or join a group and start setting your goals!',
                  style: TextStyle(
                    fontFamily: 'Montserrat-Medium',
                    fontSize: TextSize.lBody,
                    letterSpacing: 1
                  ),
                ),
                const SizedBox(height: Insets.l * 1.5),
                Image.asset(
                  'assets/icons/targetteam.png',
                  height: 380,
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
