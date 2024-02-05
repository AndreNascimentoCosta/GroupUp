import 'package:flutter/cupertino.dart';

class ButtonCommonStyle extends StatelessWidget {
  const ButtonCommonStyle({
    required this.child,
    this.onPressed,
    this.padding,
  });

  final Widget child;
  final void Function()? onPressed;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      minSize: 0,
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: child,
    );
  }
}
