import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonCommonStyle extends StatelessWidget {
  ButtonCommonStyle({
    required this.child,
    required this.onPressed,
    this.color = Colors.black,
    this.padding
  });

  Widget child;
  void Function() onPressed;
  Color color;
  EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      minSize: 0,
      padding: EdgeInsets.zero,
      child: child,
      onPressed: () {
        onPressed();
      },
    );
  }
}
