import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/screens/home/components/bottom_sheet/sign_up/sign_up_phone/pages/phone_auth_provider.dart';
import 'package:groupup/screens/home/components/bottom_sheet/sign_up/sign_up_phone/pages/first_page.dart';
import 'package:groupup/screens/home/components/bottom_sheet/sign_up/sign_up_phone/pages/second_page.dart';
import 'package:groupup/screens/home/components/next_button.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/styles/text.dart';
import 'package:provider/provider.dart';

class SignUpPhonePageView extends StatefulWidget {
  const SignUpPhonePageView({Key? key}) : super(key: key);

  @override
  State<SignUpPhonePageView> createState() => _SignUpPhonePageViewState();
}

class _SignUpPhonePageViewState extends State<SignUpPhonePageView> {
  @override
  Widget build(BuildContext context) {
    final phoneProvider = Provider.of<PhoneAuthenProvider>(context);
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: kDefaultPadding * 2),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: kDefaultPadding),
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: phoneProvider.pageIndex != 0
                        ? ButtonCommonStyle(
                            onPressed: () {
                              phoneProvider.start = 30;
                              phoneProvider.controller.previousPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.ease);
                              FocusScope.of(context).unfocus();
                              phoneProvider.cleanOtp();
                            },
                            child: SvgPicture.asset(
                              'assets/icons/arrow_left.svg',
                              color: const Color(0xFF868686),
                            ),
                          )
                        : null,
                  ),
                ),
                StandardTextStyle(
                  textAlign: TextAlign.center,
                  text: phoneProvider.pageIndex < 2
                      ? 'Continue'
                      : 'Verification code',
                  fontFamily: 'Montserrat-SemiBold',
                  fontSize: 28,
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView(
              controller: phoneProvider.controller,
              onPageChanged: phoneProvider.updateIndex,
              children: [
                FirstPageSignUp(controller: phoneProvider.controller),
                SecondPageSignUp(controller: phoneProvider.controller),
              ],
            ),
          ),
          phoneProvider.pageIndex != 0
              ? const SizedBox()
              :
          NextButton(
            onPressed: phoneProvider.nextPressedPhone(context),
          ),
          const SizedBox(height: kDefaultPadding / 4)
        ],
      ),
    );
  }
}
