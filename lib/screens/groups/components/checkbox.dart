// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';

class CheckBoxGroup extends StatefulWidget {
  CheckBoxGroup({this.isChecked, this.onChanged});

  bool? isChecked = true;
  final void Function(bool)? onChanged;

  @override
  State<CheckBoxGroup> createState() => _CheckBoxGroupState();
}

class _CheckBoxGroupState extends State<CheckBoxGroup> {

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: widget.isChecked,
      activeColor: GPColors.primaryColor,
      shape: const CircleBorder(),
      onChanged: (bool? value) {
        setState(() {
          widget.isChecked = value!;
        });
      },
    );
  }
}
