import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/home/models/text_field.dart';

class SecondPageSignUpPhone extends StatefulWidget {
  const SecondPageSignUpPhone({required this.controller});

  final PageController controller;

  @override
  State<SecondPageSignUpPhone> createState() => _SecondPageSignUpPhoneState();
}

class _SecondPageSignUpPhoneState extends State<SecondPageSignUpPhone> {
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            TextFieldModelHome(
              header: 'Phone number',
              keyboardType: TextInputType.phone,
              autoFillHints: [AutofillHints.telephoneNumber],
              hint: 'Enter your phone number',
              padding: EdgeInsets.symmetric(
                horizontal: kDefaultPadding,
              ),
            ),
            SizedBox(height: Insets.l),
          ],
        ),
      ),
    );
  }
}