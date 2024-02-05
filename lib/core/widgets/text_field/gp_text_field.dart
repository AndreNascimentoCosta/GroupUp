import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/utils/icons/gp_icons.dart';
import 'package:groupup/core/widgets/icons/gp_icon.dart';
import 'package:groupup/core/constants/design_system.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';
import 'package:provider/provider.dart';

class GPTextField extends StatelessWidget {
  const GPTextField({
    required this.controller,
    required this.header,
    required this.padding,
    this.hint,
    this.focusNode,
    this.keyboardType,
    this.initialValue,
    this.textInputAction,
    this.autoFillHints,
    this.autoFocus = false,
    this.inputFormatters,
    this.validator,
    this.maxLength,
    this.submitted,
    this.prefixIcon,
    this.autovalidateMode = AutovalidateMode.always,
  });

  final FocusNode? focusNode;
  final TextEditingController controller;
  final String header;
  final String? hint;
  final EdgeInsetsGeometry padding;
  final TextInputType? keyboardType;
  final String? initialValue;
  final TextInputAction? textInputAction;
  final Iterable<String>? autoFillHints;
  final bool autoFocus;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final int? maxLength;
  final void Function(String)? submitted;
  final Widget? prefixIcon;
  final AutovalidateMode autovalidateMode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GPTextBody(
            text: header,
          ),
          const SizedBox(height: Insets.s),
          TextFormField(
            focusNode: focusNode,
            controller: controller,
            initialValue: initialValue,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            inputFormatters: inputFormatters,
            autofillHints: autoFillHints,
            autofocus: autoFocus,
            autovalidateMode: autovalidateMode,
            validator: validator,
            maxLength: maxLength,
            onFieldSubmitted: submitted,
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    Insets.s,
                  ),
                ),
                borderSide: BorderSide(
                  color: GPColors.secondaryColor,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    Insets.s,
                  ),
                ),
                borderSide: BorderSide(
                  color: GPColors.primaryColor,
                ),
              ),
              errorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: GPColors.red),
              ),
              focusedErrorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: GPColors.red),
              ),
              prefixIcon: prefixIcon,
              prefixIconConstraints: const BoxConstraints(
                minWidth: 40,
                minHeight: 40,
              ),
              counterText: '',
              suffixIcon: controller.text.isEmpty
                  ? null
                  : IconButton(
                      icon: const GPIcon(
                        GPIcons.clear,
                        color: GPColors.secondaryColor,
                        height: Insets.l,
                        width: Insets.l,
                      ),
                      onPressed: () {
                        Provider.of<MixPanelProvider>(
                          context,
                          listen: false,
                        ).logEvent(
                          eventName: 'Clear Text',
                        );
                        controller.clear();
                      },
                    ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding / 2,
              ),
              hintText: hint,
              hintStyle: const TextStyle(
                fontFamily: 'Montserrat-Medium',
                fontSize: TextSize.mBody,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  Insets.m,
                ),
                borderSide: const BorderSide(
                  color: GPColors.secondaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
