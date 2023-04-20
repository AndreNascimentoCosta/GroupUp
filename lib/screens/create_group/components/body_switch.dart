import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
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
    final screenWidth = context.screenWidth;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Row(
        children: [
          SizedBox(
            width: screenWidth * 0.6,
            child: StaticText(
              text: widget.text,
              maxLines: 5,
              fontSize: 14,
            ),
          ),
          const Spacer(),
          widget.switchType,
        ],
      ),
    );
  }
}
