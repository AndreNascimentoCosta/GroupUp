import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/models/switch.dart';
import 'package:groupup/styles/text.dart';

class BodySwitch extends StatefulWidget {
  const BodySwitch({required this.text, required this.switchType});

  final String text;
  final Widget switchType;

  @override
  State<BodySwitch> createState() => _BodySwitchState();
}

class _BodySwitchState extends State<BodySwitch> {
  final SwitchModel switchModel = SwitchModel();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Row(
        children: [
          SizedBox(width: 250, child: StandardTextStyle(text: widget.text, fontSize:  14)),
          const Spacer(),
          widget.switchType,
        ],
      ),
    );
  }
}