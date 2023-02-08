import 'package:flutter/material.dart';
import 'package:groupup/core/widgets/texts/large_body.dart';
import 'package:groupup/core/widgets/buttons/button.dart';

class ExitGroup extends StatefulWidget {
  const ExitGroup({super.key});

  @override
  State<ExitGroup> createState() => _ExitGroupState();
}

class _ExitGroupState extends State<ExitGroup> {
  bool checkedValue = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ButtonCommonStyle(
            onPressed: () {},
            child: const LargeBody(
              text: 'Exit group',
              color: Colors.red,
            ),
          )
    );
  }
}
