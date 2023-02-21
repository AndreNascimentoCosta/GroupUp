import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/home/components/bottom_sheet/create_group/button.dart';
import 'package:groupup/screens/home/components/bottom_sheet/join/button.dart';

class AddBottomSheet extends StatelessWidget {
  const AddBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Column(
        children: const [
          SizedBox(height: Insets.l * 2.75),
          JoinGroupButton(),
          SizedBox(height: Insets.l * 1.5),
          CreateGroupButton(),
        ],
      ),
    );
  }
}
