import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/styles/text.dart';

class TextFieldModelHome extends StatefulWidget {
  const TextFieldModelHome({
    required this.controller,
    required this.header,
    required this.hint,
    required this.padding,
    this.keyboardType,
    this.textInputAction,
    this.autoFillHints,
    this.autoFocus = false,
    this.inputFormatters,
    this.validator,
    this.prefixIcon,
  });

  final TextEditingController controller;
  final String header;
  final String hint;
  final EdgeInsetsGeometry padding;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Iterable<String>? autoFillHints;
  final bool autoFocus;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;

  @override
  State<TextFieldModelHome> createState() => _TextFieldModelHomeState();
}

class _TextFieldModelHomeState extends State<TextFieldModelHome> {
  final formKey = GlobalKey<FormState>();

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
          StandardTextStyle(
            text: widget.header,
            fontSize: TextSize.lBody,
          ),
          const SizedBox(height: 5),
          TextFormField(
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            inputFormatters: widget.inputFormatters,
            autofillHints: widget.autoFillHints,
            autofocus: widget.autoFocus,
            autovalidateMode: AutovalidateMode.always,
            validator: widget.validator,
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
                suffixIcon: widget.controller.text.isEmpty
                    ? null
                    : ButtonCommonStyle(
                        child: const Icon(
                          Icons.close,
                          color: Colors.black,
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
                )),
          ),
        ],
      ),
    );
  }
}
