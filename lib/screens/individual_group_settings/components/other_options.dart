import 'package:flutter/material.dart';
import 'package:groupup/core/widgets/texts/large_body.dart';
import 'package:groupup/core/widgets/buttons/button.dart';

class OtherOptions extends StatelessWidget {
  const OtherOptions(
      {required this.onPressed, required this.text, this.color = Colors.black});

  final void Function() onPressed;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ButtonCommonStyle(
      onPressed: onPressed,
      color: color,
      child: LargeBody(text: text, color: color),
    );
  }
}
