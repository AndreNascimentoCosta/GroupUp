import 'dart:io';

import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/constants/design-system.dart';
import 'package:groupup/core/providers/phone_auth_provider.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PhoneNumberSignUp extends StatefulWidget {
  const PhoneNumberSignUp({required this.controller});

  final PageController controller;

  @override
  State<PhoneNumberSignUp> createState() => _PhoneNumberSignUpState();
}

class _PhoneNumberSignUpState extends State<PhoneNumberSignUp> {
  @override
  Widget build(BuildContext context) {
    final nodePhone = FocusNode();
    final appLocalizations = AppLocalizations.of(context)!;
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
                  GPTextBody(
                    text: appLocalizations.phoneNumber,
                    fontSize: 18,
                  ),
                  const SizedBox(
                    height: Insets.xs,
                  ),
                  IntlPhoneField(
                    focusNode: nodePhone,
                    autofocus: true,
                    pickerDialogStyle: PickerDialogStyle(
                      searchFieldInputDecoration: InputDecoration(
                        labelText: appLocalizations.searchCountry,
                      ),
                    ),
                    invalidNumberMessage: appLocalizations.invalidPhoneNumber,
                    decoration: InputDecoration(
                      hintText: appLocalizations.phoneNumber,
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
