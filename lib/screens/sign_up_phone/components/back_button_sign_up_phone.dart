import 'package:flutter/material.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/providers/phone_auth_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/utils/icons/gp_icons.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/widgets/icons/gp_icon.dart';
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
              child: const GPIcon(
                GPIcons.arrowLeft,
                color: GPColors.secondaryColor,
              ),
            )
          : null,
    );
  }
}
