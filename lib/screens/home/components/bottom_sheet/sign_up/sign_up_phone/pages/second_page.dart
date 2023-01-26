
import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/screens/home/components/bottom_sheet/sign_up/sign_up_phone/pages/otp_field.dart';
import 'package:groupup/core/providers/phone_auth_provider.dart';
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
    final authProvider = Provider.of<AuthProvider>(context);
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
              const SizedBox(height: Insets.l * 2),
              OTPField(
                controller: phoneProvider.otpCode1,
              ),
              const SizedBox(height: Insets.l * 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const StandardTextStyle(
                      text: "Didn't receive a code?",
                      fontSize: TextSize.mBody,
                      color: kSecondaryColor),
                  const SizedBox(width: Insets.xs),
                  ButtonCommonStyle(
                    onPressed: () {
                      phoneProvider.start != 0
                          ? null
                          : authProvider.phoneLogin(context);
                    },
                    child: StandardTextStyle(
                        text: phoneProvider.start != 0
                            ? 'Request again in ${phoneProvider.start} sec'
                            : 'Request again',
                        fontSize: TextSize.mBody,
                        fontFamily: 'Montserrat-SemiBold',
                        color: phoneProvider.start != 0
                            ? kSecondaryColor
                            : Colors.black),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
