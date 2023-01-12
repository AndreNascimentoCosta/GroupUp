import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/home/components/bottom_sheet/sign_up/sign_up_phone/pages/phone_auth_.dart';
import 'package:groupup/screens/home/components/text_field.dart';
import 'package:provider/provider.dart';

class FirstPageSignUpPhone extends StatefulWidget {
  const FirstPageSignUpPhone({required this.controller});

  final PageController controller;

  @override
  State<FirstPageSignUpPhone> createState() => _FirstPageSignUpPhoneState();
}

class _FirstPageSignUpPhoneState extends State<FirstPageSignUpPhone> {
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
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: Insets.l * 1.5),
            TextFieldModelHome(
              controller: phoneProvider.nameController,
              autoFocus: true,
              validator: (value) {
                if (value!.isNotEmpty && value.length < 3) {
                  return 'Name must be at least 3 characters';
                } else {
                  return null;
                }
              },
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
              controller: phoneProvider.usernameController,
              validator: (value) {
                if (value!.isNotEmpty && value.length < 3) {
                  return 'Username must be at least 3 characters';
                } else {
                  return null;
                }
              },
              header: 'Username',
              hint: 'Enter username',
              keyboardType: TextInputType.text,
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
