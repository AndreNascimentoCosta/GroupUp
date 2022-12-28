import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/home/components/text_field.dart';

class FirstPageSignUpPhone extends StatefulWidget {
  const FirstPageSignUpPhone({required this.controller});

  final PageController controller;

  @override
  State<FirstPageSignUpPhone> createState() => _FirstPageSignUpPhoneState();
}

class _FirstPageSignUpPhoneState extends State<FirstPageSignUpPhone> {
  final controllerName = TextEditingController();
  final controllerUsername = TextEditingController();

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
          children: [
            const SizedBox(height: Insets.l * 1.5),
            TextFieldModelHome(
              controller: controllerName,
              header: 'Name',
              hint: 'Enter your name',
              autoFillHints: const [AutofillHints.name],
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding,
              ),
            ),
            const SizedBox(height: Insets.l * 1.5),
            TextFieldModelHome(
              controller: controllerUsername,
              header: 'Username',
              hint: 'Enter username',
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.done,
              padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding,
              ),
            ),
            const SizedBox(height: Insets.l * 1.5),
          ],
        ),
      ),
    );
  }
}
