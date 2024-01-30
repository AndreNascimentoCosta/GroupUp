import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';
import 'package:groupup/models/switch.dart';

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
          SizedBox(
            width: context.screenWidth * 0.6,
            child: GPTextBody(
              text: widget.text,
              maxLines: 5,
            ),
          ),
          const Spacer(),
          widget.switchType,
        ],
      ),
    );
  }
}
