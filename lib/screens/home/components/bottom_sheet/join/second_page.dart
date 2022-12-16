import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/switch.dart';
import 'package:groupup/screens/home/components/bottom_sheet/create/body_switch.dart';
import 'package:groupup/screens/home/components/bottom_sheet/create/date_time.dart';
import 'package:groupup/screens/home/components/bottom_sheet/create/profile_picture_add.dart';
import 'package:groupup/styles/button.dart';
import 'package:groupup/styles/switch_button.dart';
import 'package:groupup/screens/home/models/date_switch.dart';
import 'package:groupup/screens/home/models/text_field.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SecondPageJoin extends StatefulWidget {
  const SecondPageJoin({
    required this.controller,
    required this.count,
  });

  final PageController controller;
  final int count;

  @override
  State<SecondPageJoin> createState() => _SecondPageJoinState();
}

class _SecondPageJoinState extends State<SecondPageJoin> {
  final SwitchModel switchModel = SwitchModel();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: kDefaultPadding),
              SignInWithAppleButton(
                onPressed: () {},
                text: 'Continue with Apple',
                height: 50,
                iconAlignment: IconAlignment.left,
                style: SignInWithAppleButtonStyle.whiteOutlined,
                borderRadius: BorderRadius.circular(Insets.l),
              ),
              const SizedBox(height: 20),
              ButtonCommonStyle(
                onPressed: () {},
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(Insets.l),
                    color: Colors.transparent,
                  ),
                  child: Text('Continue with Google'),
                ),
              ),
              const SizedBox(height: Insets.xs),
            ],
          ),
        ),
      ),
    );
  }
}
