import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/home/components/bottom_sheet/sign_up/sign_up_phone/pages/otp_field.dart';
import 'package:groupup/screens/home/components/bottom_sheet/sign_up/sign_up_phone/pages/phone_auth_provider.dart';
import 'package:groupup/styles/text.dart';
import 'package:provider/provider.dart';

class SecondPageSignUp extends StatefulWidget {
  const SecondPageSignUp({
    required this.controller,
  });

  final PageController controller;

  @override
  State<SecondPageSignUp> createState() => _SecondPageSignUpState();
}

class _SecondPageSignUpState extends State<SecondPageSignUp> {
  @override
  Widget build(BuildContext context) {
    final phoneProvider = Provider.of<PhoneAuthenProvider>(context);
    final phoneControllerText = phoneProvider.phoneController.text;
    
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
              const SizedBox(height: Insets.l * 2),
              StandardTextStyle(
                  text: 'Code is sent to $phoneControllerText',
                  fontSize: TextSize.mBody,
                  color: kSecondaryColor),
              const SizedBox(height: Insets.l * 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OTPField(
                    controller: phoneProvider.otpCode1,
                    autofocus: true,
                  ),
                  OTPField(controller: phoneProvider.otpCode2),
                  OTPField(controller: phoneProvider.otpCode3),
                  OTPField(controller: phoneProvider.otpCode4),
                  OTPField(controller: phoneProvider.otpCode5),
                  OTPField(controller: phoneProvider.otpCode6),
                ],
              ),
              const SizedBox(height: Insets.l * 2),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: const [
              //     StandardTextStyle(
              //         text: "Didn't receive a code?",
              //         fontSize: TextSize.mBody,
              //         color: kSecondaryColor),
              //     SizedBox(width: Insets.xs),
              //     StandardTextStyle(
              //         text: 'Request again',
              //         fontSize: TextSize.mBody,
              //         fontFamily: 'Montserrat-SemiBold',
              //         color: Colors.black),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
