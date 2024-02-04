import 'package:flutter/material.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/constants/design-system.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class SignUpOTPField extends StatelessWidget {
  const SignUpOTPField({
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    const defaultPinTheme = PinTheme(
      height: 58,
      width: 50,
      textStyle: TextStyle(
        fontFamily: 'Montserrat-Regular',
        fontSize: TextSize.subTitle,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(
              0XFFE1E1E1,
            ),
          ),
        ),
      ),
    );
    return Pinput(
      controller: controller,
      length: 6,
      animationCurve: Curves.fastOutSlowIn,
      pinAnimationType: PinAnimationType.none,
      autofillHints: const [
        AutofillHints.oneTimeCode,
      ],
      animationDuration: const Duration(
        milliseconds: 10,
      ),
      onChanged: (value) {
        if (value.length == 6) {
          authProvider.verifyOTP(context);
        }
      },
      autofocus: true,
      focusedPinTheme: defaultPinTheme.copyWith(
        decoration: defaultPinTheme.decoration!.copyWith(
          border: const Border(
            bottom: BorderSide(
              color: GPColors.primaryColor,
            ),
          ),
        ),
      ),
      separator: const SizedBox(
        width: Insets.s,
      ),
      defaultPinTheme: defaultPinTheme,
    );
  }
}
