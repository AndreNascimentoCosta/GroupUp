import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/home/components/bottom_sheet/sign_up/sign_up_phone/pages/phone_auth_.dart';
import 'package:provider/provider.dart';

class OTPField extends StatelessWidget {
  const OTPField({this.autofocus = false});

  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    final phoneProvider = Provider.of<PhoneAuthenProvider>(context);
    return SizedBox(
      height: 58,
      width: 50,
      child: TextFormField(
        controller: phoneProvider.otpCode,
        onChanged: ((value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        }),
        onTap: () {},
        autofillHints: const [AutofillHints.oneTimeCode],
        style: const TextStyle(
          fontFamily: 'Montserrat-SemiBold',
          fontSize: TextSize.lBody,
        ),
        autofocus: autofocus,
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0XFFE1E1E1),
          hintText: '0',
          hintStyle: TextStyle(
            fontFamily: 'MontSerrat-Regular',
            fontSize: TextSize.lBody,
            color: Colors.black.withOpacity(0.2),
          ),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0XFFE1E1E1),
              ),
              borderRadius: BorderRadius.all(Radius.circular(Insets.m))),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0XFFE1E1E1),
              ),
              borderRadius: BorderRadius.all(Radius.circular(Insets.m))),
        ),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
    );
  }
}
