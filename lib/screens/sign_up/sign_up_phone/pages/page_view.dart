import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/providers/phone_auth_provider.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/screens/sign_up/sign_up_phone/pages/first_page.dart';
import 'package:groupup/screens/sign_up/sign_up_phone/pages/second_page.dart';
import 'package:groupup/screens/home/components/next_button.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/providers/mix_panel_provider.dart';

class SignUpPhonePageView extends StatefulWidget {
  const SignUpPhonePageView({Key? key}) : super(key: key);

  @override
  State<SignUpPhonePageView> createState() => _SignUpPhonePageViewState();
}

class _SignUpPhonePageViewState extends State<SignUpPhonePageView> {
  @override
  Widget build(BuildContext context) {
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
                    child:
                        Provider.of<PhoneAuthenProvider>(context, listen: false)
                                    .pageIndex !=
                                0
                            ? ButtonCommonStyle(
                                onPressed: () {
                                  Provider.of<MixPanelProvider>(context,
                                          listen: false)
                                      .logEvent(eventName: 'Back Button Phone');
                                  Provider.of<PhoneAuthenProvider>(context,
                                          listen: false)
                                      .controller
                                      .previousPage(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.ease);
                                  FocusScope.of(context).unfocus();
                                  Provider.of<PhoneAuthenProvider>(context,
                                          listen: false)
                                      .cleanOtp();
                                },
                                child: SvgPicture.asset(
                                  'assets/icons/arrow_left.svg',
                                  color: const Color(0xFF868686),
                                ),
                              )
                            : null,
                  ),
                ),
                StaticText(
                  textAlign: TextAlign.center,
                  text: Provider.of<PhoneAuthenProvider>(context, listen: false)
                              .pageIndex <
                          2
                      ? AppLocalizations.of(context).continuePN
                      : AppLocalizations.of(context).verificationCode,
                  fontFamily: 'Montserrat-SemiBold',
                  fontSize: 28,
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView(
              controller:
                  Provider.of<PhoneAuthenProvider>(context, listen: false)
                      .controller,
              onPageChanged:
                  Provider.of<PhoneAuthenProvider>(context, listen: false)
                      .updateIndex,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                FirstPageSignUp(
                    controller:
                        Provider.of<PhoneAuthenProvider>(context, listen: false)
                            .controller),
                SecondPageSignUp(
                    controller:
                        Provider.of<PhoneAuthenProvider>(context, listen: false)
                            .controller),
              ],
            ),
          ),
          Builder(builder: (context) {
            return Provider.of<PhoneAuthenProvider>(context).pageIndex != 0
                ? const SizedBox()
                : NextButton(
                    onPressed: Provider.of<PhoneAuthenProvider>(context)
                        .nextPressedPhone(context),
                  );
          }),
          const SizedBox(height: kDefaultPadding / 4)
        ],
      ),
    );
  }
}
