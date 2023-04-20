import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/screens/create_group/button.dart';
import 'package:groupup/screens/join_group/components/button.dart';

class AddBottomSheet extends StatelessWidget {
  const AddBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = context.screenHeight;
    final screenWidth = context.screenWidth;
    final isSmallScreen = screenHeight < 800 || screenWidth < 350;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Column(
        children: [
          SizedBox(height: isSmallScreen ? screenHeight * 0.05 : screenHeight * 0.055),
          const JoinGroupButton(),
          SizedBox(height: isSmallScreen ? screenHeight * 0.025 : screenHeight * 0.035),
          const CreateGroupButton(),
        ],
      ),
    );
  }
}
