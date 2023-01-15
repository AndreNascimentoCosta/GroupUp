import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/constants.dart';

class TextFieldModel extends StatelessWidget {
  const TextFieldModel({
    required this.hint,
    required this.maxLength,
    this.controller,
    this.border,
    this.hintColor,
    this.hintSize,
    this.keyboardType = TextInputType.text,
    this.autofillHints,
    this.textInputAction,
  });

  final TextEditingController? controller;
  final String hint;
  final int maxLength;
  final InputBorder? border;
  final Color? hintColor;
  final double? hintSize;
  final TextInputType keyboardType;
  final Iterable<String>? autofillHints;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SizedBox(
        height: 100,
        width: 220,
        child: TextFormField(
          style: const TextStyle(
            fontFamily: 'Montserrat-Medium',
          ),
          keyboardType: keyboardType,
          autofillHints: autofillHints,
          textInputAction: textInputAction,
          controller: controller,
          maxLength: maxLength,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            enabledBorder: border,
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: kPrimaryColor)),
            hintText: hint,
            counterText: "",
            suffixIcon: controller!.text.isEmpty
                ? null
                : IconButton(
                    icon: SvgPicture.asset(
                      'assets/icons/clear.svg',
                      height: 20,
                      width: 20,
                      color: kSecondaryColor,
                    ),
                    onPressed: () {
                      controller!.clear();
                    },
                  ),
            hintStyle: TextStyle(
              fontFamily: 'Montserrat-Medium',
              color: hintColor,
              fontSize: hintSize,
            ),
          ),
        ),
      ),
    );
  }
}
