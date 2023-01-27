import 'dart:io';

import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/core/providers/phone_auth_provider.dart';
import 'package:groupup/styles/text.dart';
import 'package:provider/provider.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class FirstPageSignUp extends StatefulWidget {
  const FirstPageSignUp({required this.controller});

  final PageController controller;

  @override
  State<FirstPageSignUp> createState() => _FirstPageSignUpState();
}

class _FirstPageSignUpState extends State<FirstPageSignUp> {
  @override
  Widget build(BuildContext context) {
    final phoneProvider = Provider.of<PhoneAuthenProvider>(context);
    final nodePhone = FocusNode();
    PhoneNumber number =
      PhoneNumber(isoCode: Platform.localeName.split('_').last);
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
                      focusNode: nodePhone,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).nextFocus();
                      },
                      autofillHints: const [AutofillHints.telephoneNumber],
                      autoFocus: true,
                      initialValue: number,
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
