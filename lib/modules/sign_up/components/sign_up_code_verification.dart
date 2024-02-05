import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/constants/design_system.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';
import 'package:groupup/modules/sign_up/components/sign_up_events.dart';
import 'package:groupup/modules/sign_up/components/sign_up_otp_field.dart';
import 'package:groupup/core/providers/phone_auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpCodeVerification extends StatefulWidget {
  const SignUpCodeVerification({
    required this.controller,
  });

  final PageController controller;

  @override
  State<SignUpCodeVerification> createState() => _SignUpCodeVerificationState();
}

class _SignUpCodeVerificationState extends State<SignUpCodeVerification> {
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final phoneProvider = Provider.of<PhoneAuthenProvider>(
      context,
    );
    final authProvider = Provider.of<AuthProvider>(
      context,
    );
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
          padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: Insets.l * 2,
              ),
              GPTextBody(
                text: appLocalizations.codeSent(
                  phoneControllerText,
                ),
                color: GPColors.secondaryColor,
              ),
              const SizedBox(
                height: Insets.l * 2,
              ),
              SignUpOTPField(
                controller: phoneProvider.otpCode1,
              ),
              const SizedBox(
                height: Insets.l * 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GPTextBody(
                    text: appLocalizations.codeNotReceived,
                    color: GPColors.secondaryColor,
                  ),
                  const SizedBox(
                    width: Insets.xs,
                  ),
                  ButtonCommonStyle(
                    onPressed: () {
                      if (phoneProvider.start != 0) {
                        return;
                      } else {
                        Provider.of<MixPanelProvider>(
                          context,
                          listen: false,
                        ).logEvent(
                          eventName: SignUpEvents.pressRequestCodeAgain.value,
                        );
                        phoneProvider.startTimerOTPCode();
                        authProvider.phoneLogin(
                          context,
                        );
                      }
                    },
                    child: GPTextBody(
                      text: phoneProvider.start != 0
                          ? appLocalizations.waitingRequestAgain(
                              phoneProvider.start,
                            )
                          : appLocalizations.requestAgain,
                      fontFamily: 'Montserrat-SemiBold',
                      color: phoneProvider.start != 0
                          ? GPColors.secondaryColor
                          : GPColors.black,
                    ),
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
