import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/providers/phone_auth_provider.dart';
import 'package:groupup/core/widgets/texts/gp_text_header.dart';
import 'package:groupup/screens/sign_up/components/back_button_sign_up_phone.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TitleSignUpPhone extends StatelessWidget {
  const TitleSignUpPhone({super.key});

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
                : const BackButtonSignUpPhone(),
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
                  )!.continuePN
                : AppLocalizations.of(
                    context,
                  )!.verificationCode,
            fontSize: 28,
          ),
        ],
      ),
    );
  }
}
