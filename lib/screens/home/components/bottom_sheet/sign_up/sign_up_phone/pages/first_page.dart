import 'dart:io';

import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/core/providers/phone_auth_provider.dart';
import 'package:groupup/styles/text.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

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
                    IntlPhoneField(
                      focusNode: nodePhone,
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        labelStyle: TextStyle(
                          color: kPrimaryColor,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                      ),
                      initialCountryCode: Platform.localeName.split('_').last,
                      onChanged: (phoneNumber) {
                        phoneProvider.phoneController.text =
                            phoneNumber.completeNumber;
                      },
                    ),
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
