import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/providers/phone_auth_provider.dart';
import 'package:groupup/modules/sign_up/components/title_sign_up_phone.dart';
import 'package:groupup/modules/sign_up/components/phone_number_sign_up.dart';
import 'package:groupup/modules/sign_up/components/code_verification_sign_up.dart';
import 'package:groupup/core/widgets/buttons/gp_button.dart';
import 'package:provider/provider.dart';

class SignUpPhonePageViewScreen extends StatefulWidget {
  const SignUpPhonePageViewScreen({Key? key}) : super(key: key);

  @override
  State<SignUpPhonePageViewScreen> createState() => _SignUpPhonePageViewScreenState();
}

class _SignUpPhonePageViewScreenState extends State<SignUpPhonePageViewScreen> {
  @override
  Widget build(BuildContext context) {
    final phoneProvider = Provider.of<PhoneAuthenProvider>(
      context,
      listen: false,
    );
    return SafeArea(
      child: Column(
        children: [
          const TitleSignUpPhone(),
          Expanded(
            child: PageView(
              controller: phoneProvider.controller,
              onPageChanged: phoneProvider.updateIndex,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                PhoneNumberSignUp(
                  controller: phoneProvider.controller,
                ),
                CodeVerificationSignUp(
                  controller: phoneProvider.controller,
                ),
              ],
            ),
          ),
          Builder(
            builder: (context) {
              return Provider.of<PhoneAuthenProvider>(
                        context,
                      ).pageIndex !=
                      0
                  ? const SizedBox()
                  : GPButton(
                      onPressed: Provider.of<PhoneAuthenProvider>(
                        context,
                      ).nextPressedPhone(
                        context,
                      ),
                    );
            },
          ),
          const SizedBox(
            height: kDefaultPadding / 4,
          )
        ],
      ),
    );
  }
}
