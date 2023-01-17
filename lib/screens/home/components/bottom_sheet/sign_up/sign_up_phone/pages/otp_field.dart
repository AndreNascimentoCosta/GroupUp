import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/home/components/bottom_sheet/sign_up/auth_provider.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OTPField extends StatelessWidget {
  const OTPField({
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
        // color: Color(0XFFE1E1E1),
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
      animationDuration: const Duration(milliseconds: 10),
      onClipboardFound: (value) {
        controller.text = value;
      },
      onChanged: (value) {
        if (value.length == 6) {
          authProvider.verifyOTP(context);
        }
      },
      autofocus: true,
      focusedPinTheme: defaultPinTheme.copyWith(
        decoration: defaultPinTheme.decoration!.copyWith(
          border: const Border(
            bottom: BorderSide(color: kPrimaryColor),
          ),
        ),
      ),
      separator: const SizedBox(width: Insets.s),
      defaultPinTheme: defaultPinTheme,
    );
  }
}
