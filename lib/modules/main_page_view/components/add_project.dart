import 'package:flutter/material.dart';
import 'package:groupup/core/bottom_sheet/gp_modal_bottom_sheet.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/constants/design-system.dart';
import 'package:groupup/core/utils/icons/gp_icons.dart';
import 'package:groupup/core/widgets/icons/gp_icon.dart';
import 'package:groupup/modules/create_group/button.dart';
import 'package:groupup/modules/join_group/components/button.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/mix_panel_provider.dart';

class AddProject extends StatelessWidget {
  const AddProject({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = context.screenHeight;
    final screenWidth = context.screenWidth;
    final isSmallScreen = screenHeight < 800 || screenWidth < 350;
    return FloatingActionButton(
      onPressed: () {
        Provider.of<MixPanelProvider>(context, listen: false)
            .logEvent(eventName: 'Add Project Button');
        gpModalBottomSheet(
          context,
          context.screenHeight * 0.35,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Column(
              children: [
                SizedBox(
                    height: isSmallScreen
                        ? screenHeight * 0.05
                        : screenHeight * 0.055),
                const JoinGroupButton(),
                SizedBox(
                    height: isSmallScreen
                        ? screenHeight * 0.025
                        : screenHeight * 0.035),
                const CreateGroupButton(),
              ],
            ),
          ),
        );
      },
      backgroundColor: GPColors.primaryColor,
      highlightElevation: 0,
      elevation: 0,
      child: const GPIcon(
        GPIcons.plus,
        height: Insets.l * 1.5,
        width: Insets.l * 1.5,
      ),
    );
  }
}
