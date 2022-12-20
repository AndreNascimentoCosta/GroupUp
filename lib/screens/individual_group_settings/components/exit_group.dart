import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/styles/button.dart';
import 'package:groupup/styles/text.dart';

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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: kDefaultPadding),
          CheckboxListTile(
              title: const StandardTextStyle(
                  text: 'Request refund', fontSize: TextSize.lBody),
              activeColor: kPrimaryColor,
              checkboxShape: const CircleBorder(),
              value: checkedValue,
              onChanged: ((value) {
                setState(() {
                  checkedValue = value!;
                });
              })),
          const SizedBox(height: kDefaultPadding),
          ButtonCommonStyle(
            onPressed: () {},
            child: const StandardTextStyle(
              text: 'Exit group',
              fontSize: TextSize.lBody,
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}
