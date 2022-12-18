import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/home/components/bottom_sheet/sign_up_phone/otp_field.dart';
import 'package:groupup/screens/home/models/text_field.dart';
import 'package:groupup/styles/text.dart';

class ThirdPageSignUpPhone extends StatefulWidget {
  const ThirdPageSignUpPhone({required this.controller});

  final PageController controller;

  @override
  State<ThirdPageSignUpPhone> createState() => _ThirdPageSignUpPhoneState();
}

class _ThirdPageSignUpPhoneState extends State<ThirdPageSignUpPhone> {
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
              const SizedBox(height: Insets.l * 1.5),
              const StandardTextStyle(
                  text: 'Code is sent to +47 99613-6762',
                  fontSize: TextSize.mBody,
                  color: kSecondaryColor),
              const SizedBox(height: Insets.l * 1.5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  OTPField(autofocus: true,),
                  OTPField(),
                  OTPField(),
                  OTPField(),
                ],
              ),
              const SizedBox(height: Insets.l * 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  StandardTextStyle(
                      text: "Didn't receive a code?",
                      fontSize: TextSize.mBody,
                      color: kSecondaryColor),
                  SizedBox(width: Insets.xs),
                  StandardTextStyle(
                      text: 'Request again',
                      fontSize: TextSize.mBody,
                      fontFamily: 'Montserrat-SemiBold',
                      color: Colors.black),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
