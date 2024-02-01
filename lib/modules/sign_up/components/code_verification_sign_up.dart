import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/constants/design-system.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';
import 'package:groupup/modules/sign_up/components/otp_field.dart';
import 'package:groupup/core/providers/phone_auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/providers/mix_panel_provider.dart';

class CodeVerificationSignUp extends StatefulWidget {
  const CodeVerificationSignUp({
    required this.controller,
  });

  final PageController controller;

  @override
  State<CodeVerificationSignUp> createState() => _CodeVerificationSignUpState();
}

class _CodeVerificationSignUpState extends State<CodeVerificationSignUp> {
  @override
  Widget build(BuildContext context) {
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
                text: AppLocalizations.of(
                  context,
                )!.codeSent(
                  phoneControllerText,
                ),
                color: GPColors.secondaryColor,
              ),
              const SizedBox(
                height: Insets.l * 2,
              ),
              OTPField(
                controller: phoneProvider.otpCode1,
              ),
              const SizedBox(
                height: Insets.l * 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GPTextBody(
                    text: AppLocalizations.of(
                      context,
                    )!.codeNotReceived,
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
                          eventName: 'Request Code Again',
                        );
                        phoneProvider.startTimer();
                        authProvider.phoneLogin(
                          context,
                        );
                      }
                    },
                    child: GPTextBody(
                      text: phoneProvider.start != 0
                          ? AppLocalizations.of(
                              context,
                            )!.waitingRequestAgain(
                              phoneProvider.start,
                            )
                          : AppLocalizations.of(
                              context,
                            )!.requestAgain,
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