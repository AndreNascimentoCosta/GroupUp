import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/providers/phone_auth_provider.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:provider/provider.dart';

class BackButtonSignUpPhone extends StatelessWidget {
  const BackButtonSignUpPhone({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Provider.of<PhoneAuthenProvider>(
                context,
                listen: false,
              ).pageIndex !=
              0
          ? ButtonCommonStyle(
              onPressed: () {
                Provider.of<MixPanelProvider>(context, listen: false).logEvent(
                  eventName: 'Back Button Phone',
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
                ).cleanOtp();
              },
              child: SvgPicture.asset(
                'assets/icons/arrow_left.svg',
                color: const Color(
                  0xFF868686,
                ),
              ),
            )
          : null,
    );
  }
}
