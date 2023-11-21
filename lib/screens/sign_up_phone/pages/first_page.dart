import 'dart:io';

import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/core/constants/design-system.dart';
import 'package:groupup/core/providers/phone_auth_provider.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FirstPageSignUp extends StatefulWidget {
  const FirstPageSignUp({required this.controller});

  final PageController controller;

  @override
  State<FirstPageSignUp> createState() => _FirstPageSignUpState();
}

class _FirstPageSignUpState extends State<FirstPageSignUp> {
  @override
  Widget build(BuildContext context) {
    final nodePhone = FocusNode();
    return Center(
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
                  StaticText(
                    text: AppLocalizations.of(
                      context,
                    )!.phoneNumber,
                    fontSize: TextSize.lBody,
                  ),
                  const SizedBox(
                    height: Insets.xs,
                  ),
                  IntlPhoneField(
                    focusNode: nodePhone,
                    autofocus: true,
                    pickerDialogStyle: PickerDialogStyle(
                      searchFieldInputDecoration: InputDecoration(
                        labelText: AppLocalizations.of(
                          context,
                        )!.searchCountry,
                      ),
                    ),
                    invalidNumberMessage: AppLocalizations.of(
                      context,
                    )!.invalidPhoneNumber,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(
                        context,
                      )!.phoneNumber,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                    initialCountryCode: Platform.localeName
                        .split(
                          '_',
                        )
                        .last,
                    onChanged: (phone) {
                      Provider.of<PhoneAuthenProvider>(
                        context,
                        listen: false,
                      ).setPhone(
                        phone.completeNumber,
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: Insets.l,
            ),
          ],
        ),
      ),
    );
  }
}
