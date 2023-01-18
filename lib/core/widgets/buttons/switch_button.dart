import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';

class SwitchButton extends StatefulWidget {
  const SwitchButton({required this.onChanged});

  final void Function(bool) onChanged;

  @override
  State<SwitchButton> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Switch.adaptive(
      value: value,
      activeColor: kPrimaryColor,
      onChanged: (value) {
        setState(() {
          this.value = value;
        });
        widget.onChanged(value);
      },
    );
  }
}
