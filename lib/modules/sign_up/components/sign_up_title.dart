import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/providers/phone_auth_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/utils/icons/gp_icons.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/widgets/icons/gp_icon.dart';
import 'package:groupup/core/widgets/texts/gp_text_header.dart';
import 'package:groupup/modules/sign_up/components/sign_up_events.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpTitle extends StatelessWidget {
  const SignUpTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: kDefaultPadding * 2,
      ),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: kDefaultPadding,
            ),
            child: Provider.of<PhoneAuthenProvider>(context).pageIndex == 0
                ? const SizedBox()
                : Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Provider.of<PhoneAuthenProvider>(
                              context,
                              listen: false,
                            ).pageIndex !=
                            0
                        ? ButtonCommonStyle(
                            onPressed: () {
                              Provider.of<MixPanelProvider>(context,
                                      listen: false)
                                  .logEvent(
                                eventName:
                                    SignUpEvents.pressBackButtonSignUp.value,
                              );
                              Provider.of<PhoneAuthenProvider>(
                                context,
                                listen: false,
                              ).controller.previousPage(
                                  duration: const Duration(
                                    milliseconds: 300,
                                  ),
                                  curve: Curves.ease);
                              FocusScope.of(context).unfocus();
                              Provider.of<PhoneAuthenProvider>(
                                context,
                                listen: false,
                              ).clean();
                            },
                            child: const GPIcon(
                              GPIcons.arrowLeft,
                              color: GPColors.secondaryColor,
                            ),
                          )
                        : null,
                  ),
          ),
          GPTextHeader(
            textAlign: TextAlign.center,
            text: Provider.of<PhoneAuthenProvider>(
                      context,
                      listen: false,
                    ).pageIndex <
                    2
                ? AppLocalizations.of(
                    context,
                  )!
                    .continuePN
                : AppLocalizations.of(
                    context,
                  )!
                    .verificationCode,
            fontSize: 28,
          ),
        ],
      ),
    );
  }
}
