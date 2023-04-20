import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/providers/phone_auth_provider.dart';
import 'package:groupup/screens/sign_up_phone/components/title_sign_up_phone.dart';
import 'package:groupup/screens/sign_up_phone/pages/first_page.dart';
import 'package:groupup/screens/sign_up_phone/pages/second_page.dart';
import 'package:groupup/core/widgets/buttons/gp_button.dart';
import 'package:provider/provider.dart';

class SignUpPhonePageView extends StatefulWidget {
  const SignUpPhonePageView({Key? key}) : super(key: key);

  @override
  State<SignUpPhonePageView> createState() => _SignUpPhonePageViewState();
}

class _SignUpPhonePageViewState extends State<SignUpPhonePageView> {
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
                FirstPageSignUp(
                  controller: phoneProvider.controller,
                ),
                SecondPageSignUp(
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
