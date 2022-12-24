import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/styles/text.dart';

class TextFieldModelHome extends StatefulWidget {
  const TextFieldModelHome({
    required this.header,
    required this.hint,
    required this.padding,
    this.keyboardType,
    this.textInputAction,
    this.autoFillHints,
    this.autoFocus = false,
  });

  final String header;
  final String hint;
  final EdgeInsetsGeometry padding;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Iterable<String>? autoFillHints;
  final bool autoFocus;

  @override
  State<TextFieldModelHome> createState() => _TextFieldModelHomeState();
}

class _TextFieldModelHomeState extends State<TextFieldModelHome> {
  final nameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    nameController.addListener(() {
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
          TextField(
            controller: nameController,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            autofillHints: widget.autoFillHints,
            autofocus: widget.autoFocus,
            decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(Insets.s)),
                  borderSide: BorderSide(color: kSecondaryColor),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(Insets.s)),
                  borderSide: BorderSide(color: kPrimaryColor),
                ),
                suffixIcon: nameController.text.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          nameController.clear();
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
