import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/providers/phone_auth_provider.dart';
import 'package:groupup/modules/sign_up/components/sign_up_title.dart';
import 'package:groupup/modules/sign_up/components/sign_up_phone_number.dart';
import 'package:groupup/modules/sign_up/components/sign_up_code_verification.dart';
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
          const SignUpTitle(),
          Expanded(
            child: PageView(
              controller: phoneProvider.controller,
              onPageChanged: phoneProvider.updateIndex,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                SignUpPhoneNumber(
                  controller: phoneProvider.controller,
                ),
                SignUpCodeVerification(
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
