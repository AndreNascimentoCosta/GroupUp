import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/screens/home/components/bottom_sheet/create_group/button.dart';
import 'package:groupup/screens/home/components/bottom_sheet/join/button.dart';

class AddBottomSheet extends StatelessWidget {
  const AddBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
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
