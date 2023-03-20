import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/screens/home/components/bottom_sheet/sign_up/sign_up_phone/pages/otp_field.dart';
import 'package:groupup/core/providers/phone_auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../../core/providers/mix_panel_provider.dart';

class SecondPageSignUp extends StatefulWidget {
  const SecondPageSignUp({
    required this.controller,
  });

  final PageController controller;

  @override
  State<SecondPageSignUp> createState() => _SecondPageSignUpState();
}

class _SecondPageSignUpState extends State<SecondPageSignUp> {
  @override
  Widget build(BuildContext context) {
    final phoneProvider = Provider.of<PhoneAuthenProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final phoneControllerText = phoneProvider.phoneController;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: Insets.l * 2),
              StaticText(
                  text: AppLocalizations.of(context)
                      .codeSent(phoneControllerText),
                  fontSize: TextSize.mBody,
                  color: kSecondaryColor),
              const SizedBox(height: Insets.l * 2),
              OTPField(
                controller: phoneProvider.otpCode1,
              ),
              const SizedBox(height: Insets.l * 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StaticText(
                      text: AppLocalizations.of(context).codeNotReceived,
                      fontSize: TextSize.mBody,
                      color: kSecondaryColor),
                  const SizedBox(width: Insets.xs),
                  ButtonCommonStyle(
                    onPressed: () {
                      if (phoneProvider.start != 0) {
                        return;
                      } else {
                        Provider.of<MixPanelProvider>(context, listen: false)
                            .logEvent(eventName: 'Request Code Again');
                        phoneProvider.startTimer();
                        authProvider.phoneLogin(context);
                      }
                    },
                    child: StaticText(
                        text: phoneProvider.start != 0
                            ? AppLocalizations.of(context)
                                .waitingRequestAgain(phoneProvider.start)
                            : AppLocalizations.of(context).requestAgain,
                        fontSize: TextSize.mBody,
                        fontFamily: 'Montserrat-SemiBold',
                        color: phoneProvider.start != 0
                            ? kSecondaryColor
                            : Colors.black),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
