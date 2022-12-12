import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';

class CheckBoxGroup extends StatefulWidget {
  CheckBoxGroup({this.isChecked, this.onChanged});

  bool? isChecked = true;
  void Function(bool)? onChanged;

  @override
  State<CheckBoxGroup> createState() => _CheckBoxGroupState();
}

class _CheckBoxGroupState extends State<CheckBoxGroup> {

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: widget.isChecked,
      activeColor: kPrimaryColor,
      shape: const CircleBorder(),
      onChanged: (bool? value) {
        setState(() {
          widget.isChecked = value!;
        });
      },
    );
  }
}
