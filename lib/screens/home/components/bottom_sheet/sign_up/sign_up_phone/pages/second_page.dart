import 'dart:io';

import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/home/components/bottom_sheet/sign_up/auth_provider.dart';
import 'package:groupup/screens/home/components/bottom_sheet/sign_up/sign_up_phone/pages/phone_auth_provider.dart';
import 'package:groupup/styles/text.dart';
import 'package:provider/provider.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class SecondPageSignUpPhone extends StatefulWidget {
  const SecondPageSignUpPhone({required this.controller});

  final PageController controller;

  @override
  State<SecondPageSignUpPhone> createState() => _SecondPageSignUpPhoneState();
}

class _SecondPageSignUpPhoneState extends State<SecondPageSignUpPhone> {
  @override
  Widget build(BuildContext context) {
    final phoneProvider = Provider.of<PhoneAuthenProvider>(context);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const StandardTextStyle(
                      text: 'Phone number',
                      fontSize: TextSize.lBody,
                    ),
                    const SizedBox(height: 5),
                    InternationalPhoneNumberInput(
                      autofillHints: const [AutofillHints.telephoneNumber],
                      autoFocus: true,
                      initialValue: PhoneNumber(
                        isoCode: Platform.localeName.split('_')[1],
                      ),
                      selectorConfig: const SelectorConfig(
                        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                      ),
                      onInputChanged: (phoneNumber) {
                        phoneProvider.phoneController.text =
                            phoneNumber.phoneNumber ?? '';
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(height: Insets.l),
            ],
          ),
        ),
      ),
    );
  }
  
}
