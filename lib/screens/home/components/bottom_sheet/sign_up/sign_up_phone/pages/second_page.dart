import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/home/components/bottom_sheet/sign_up/auth_provider.dart';
import 'package:groupup/styles/text.dart';
import 'package:provider/provider.dart';

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
                  TextField(
                    controller: context.watch<AuthProvider>().phoneController,
                    keyboardType: TextInputType.phone,
                    autofillHints: const [AutofillHints.telephoneNumber],
                    autofocus: true,
                    decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(Insets.s)),
                          borderSide: BorderSide(color: kSecondaryColor),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(Insets.s)),
                          borderSide: BorderSide(color: kPrimaryColor),
                        ),
                        suffixIcon: context
                                .watch<AuthProvider>()
                                .phoneController
                                .text
                                .isEmpty
                            ? null
                            : IconButton(
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  context
                                      .watch<AuthProvider>()
                                      .phoneController
                                      .clear();
                                },
                              ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: kDefaultPadding / 2),
                        hintText: 'Enter your phone number',
                        hintStyle: const TextStyle(
                          fontFamily: 'Montserrat-Medium',
                          fontSize: TextSize.mBody,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Insets.m),
                          borderSide: const BorderSide(color: kSecondaryColor),
                        )),
                  ),
                ],
              ),
            ),
            const SizedBox(height: Insets.l),
          ],
        ),
      ),
    );
  }
}
