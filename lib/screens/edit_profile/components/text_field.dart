import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:provider/provider.dart';

import '../../../core/providers/mix_panel_provider.dart';

class TextFieldModel extends StatelessWidget {
  const TextFieldModel({
    required this.hint,
    required this.maxLength,
    required this.controller,
    this.maxLines,
    this.validator,
    this.inputFormatters,
    this.border,
    this.hintColor,
    this.hintSize,
    this.keyboardType = TextInputType.text,
    this.autofillHints,
    this.textInputAction,
  });

  final TextEditingController controller;
  final String hint;
  final int maxLength;
  final int? maxLines;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
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
          autofocus: true,
          maxLength: maxLength,
          maxLines: maxLines,
          validator: validator,
          inputFormatters: inputFormatters,
          autovalidateMode: AutovalidateMode.always,
          cursorColor: GPColors.black,
          decoration: InputDecoration(
            enabledBorder: border,
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: GPColors.primaryColor)),
            errorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: GPColors.red)),
            focusedErrorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: GPColors.red)),
            hintText: hint,
            counterText: "",
            suffixIcon: controller.text.isEmpty
                ? null
                : IconButton(
                    icon: SvgPicture.asset(
                      'assets/icons/clear.svg',
                      height: 20,
                      width: 20,
                      color: GPColors.secondaryColor,
                    ),
                    onPressed: () {
                      Provider.of<MixPanelProvider>(context, listen: false)
                          .logEvent(eventName: 'Clear Text');
                      controller.clear();
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
