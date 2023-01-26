import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';

// ignore: must_be_immutable
class SwitchButton extends StatefulWidget {
  SwitchButton({required this.onChanged, this.boolValue = false});

  final void Function(bool) onChanged;
  bool? boolValue;

  @override
  State<SwitchButton> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  @override
  Widget build(BuildContext context) {
    return Switch.adaptive(
      value: widget.boolValue ?? false,
      activeColor: kPrimaryColor,
      onChanged: (value) {
        setState(() {
          widget.boolValue = value;
        });
        widget.onChanged(value);
      },
    );
  }
}
