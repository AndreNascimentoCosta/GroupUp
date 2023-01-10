import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/models/switch.dart';

class DateSwitch extends StatefulWidget {
  const DateSwitch({required this.switchModel});

  final SwitchModel switchModel;

  @override
  State<DateSwitch> createState() => _DateSwitchState();
}

class _DateSwitchState extends State<DateSwitch> {
  @override
  Widget build(BuildContext context) {
    return Switch.adaptive(
      value: widget.switchModel.isSwitched.value,
      activeColor: kPrimaryColor,
      onChanged: (value) {
        setState(() {
          widget.switchModel.switchEdit();
        });
      },
    );
  }
}
