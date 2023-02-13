import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';

class TextFieldModelHome extends StatefulWidget {
  const TextFieldModelHome({
    required this.controller,
    required this.header,
    required this.padding,
    this.keyUnique,
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

  final Key? keyUnique;
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
  State<TextFieldModelHome> createState() => _TextFieldModelHomeState();
}

class _TextFieldModelHomeState extends State<TextFieldModelHome> {
  @override
  void initState() {
    super.initState();

    widget.controller.addListener(() {
      if (!mounted) return;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StaticText(
            text: widget.header,
            fontSize: TextSize.sBody,
          ),
          const SizedBox(height: Insets.s),
          TextFormField(
            key: widget.keyUnique,
            focusNode: widget.focusNode,
            controller: widget.controller,
            initialValue: widget.initialValue,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            inputFormatters: widget.inputFormatters,
            autofillHints: widget.autoFillHints,
            autofocus: widget.autoFocus,
            autovalidateMode: widget.autovalidateMode,
            validator: widget.validator,
            maxLength: widget.maxLength,
            onFieldSubmitted: widget.submitted,
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(Insets.s)),
                borderSide: BorderSide(color: kSecondaryColor),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(Insets.s)),
                borderSide: BorderSide(color: kPrimaryColor),
              ),
              prefixIcon: widget.prefixIcon,
              prefixIconConstraints: const BoxConstraints(
                minWidth: 40,
                minHeight: 40,
              ),
              counterText: '',
              suffixIcon: widget.controller.text.isEmpty
                  ? null
                  : IconButton(
                      icon: SvgPicture.asset(
                        'assets/icons/clear.svg',
                        height: 20,
                        width: 20,
                        color: kSecondaryColor,
                      ),
                      onPressed: () {
                        widget.controller.clear();
                      },
                    ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
              hintText: widget.hint,
              hintStyle: const TextStyle(
                fontFamily: 'Montserrat-Medium',
                fontSize: TextSize.mBody,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Insets.m),
                borderSide: const BorderSide(color: kSecondaryColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
