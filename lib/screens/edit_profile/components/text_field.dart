import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';

class TextFieldModel extends StatefulWidget {
  const TextFieldModel(
      {required this.hint, required this.maxLength, this.border, this.hintColor, this. hintSize});

  final String hint;
  final int maxLength;
  final InputBorder? border;
  final Color? hintColor;
  final double? hintSize;

  @override
  State<TextFieldModel> createState() => _TextFieldModelState();
}

class _TextFieldModelState extends State<TextFieldModel> {
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
    return GestureDetector(
      child: SizedBox(
        height: 100,
        width: 220,
        child: TextField(
            style: const TextStyle(
              fontFamily: 'Montserrat-Medium',
            ),
            // buildCounter: (context,
            //     {required currentLength, required isFocused, maxLength}) {
            //   return isFocused
            //       ? Padding(
            //           padding: const EdgeInsets.only(
            //               right: kDefaultPadding * 0.75),
            //           child: Text(
            //             (maxLength! - currentLength).toString(),
            //             style: const TextStyle(
            //               fontFamily: 'Montserrat-Medium',
            //               fontSize: 12,
            //             ),
            //           ),
            //         )
            //       : null;
            // },
            keyboardType: TextInputType.text,
            controller: nameController,
            maxLength: widget.maxLength,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              enabledBorder: widget.border,
              focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              hintText: widget.hint,
              counterText: "",
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
              hintStyle: TextStyle(
                fontFamily: 'Montserrat-Medium',
                color: widget.hintColor,
                fontSize: widget.hintSize,
              ),
            )),
      ),
    );
  }
}
