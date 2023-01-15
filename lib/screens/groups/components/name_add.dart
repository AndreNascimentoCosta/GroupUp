import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/screens/home/components/bottom_sheet/sign_up/sign_up_phone/pages/phone_auth_provider.dart';
import 'package:groupup/screens/home/components/next_button.dart';
import 'package:groupup/screens/home/components/text_field.dart';
import 'package:groupup/styles/text.dart';
import 'package:provider/provider.dart';

class NameAdd extends StatefulWidget {
  const NameAdd({required this.controller});

  final PageController controller;

  @override
  State<NameAdd> createState() => _NameAddState();
}

class _NameAddState extends State<NameAdd> {
  @override
  Widget build(BuildContext context) {
    final phoneProvider = Provider.of<PhoneAuthenProvider>(context);
    return SafeArea(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: kDefaultPadding * 2),
            child: StandardTextStyle(
              textAlign: TextAlign.center,
              text: 'Name',
              fontFamily: 'Montserrat-SemiBold',
              fontSize: 28,
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: Center(
                child: SingleChildScrollView(
                  child: TextFieldModelHome(
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
                ),
              ),
            ),
          ),
          NextButton(
            onPressed: phoneProvider.nextPressedName(context),
          ),
          const SizedBox(height: kDefaultPadding / 4)
        ],
      ),
    );
  }
}
