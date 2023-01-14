import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/home/components/bottom_sheet/sign_up/sign_up_phone/pages/phone_auth_provider.dart';
import 'package:provider/provider.dart';

class OTPField extends StatelessWidget {
  const OTPField({
    required this.controller,
    this.autofocus = false,
  });

  final bool autofocus;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final phoneProvider = Provider.of<PhoneAuthenProvider>(context);
    return SizedBox(
      height: 58,
      width: 50,
      child: TextFormField(
        controller: controller,
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          } else {
            phoneProvider.onPaste(value);
            FocusScope.of(context).unfocus();
          }
        },
        autofillHints: const [AutofillHints.oneTimeCode],
        style: const TextStyle(
          fontFamily: 'Montserrat-SemiBold',
          fontSize: TextSize.lBody,
        ),
        autofocus: true,
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
          LengthLimitingTextInputFormatter(controller.text.isEmpty ? 6 : 1),
          FilteringTextInputFormatter.digitsOnly,
          
        ],
      ),
    );
  }
}
