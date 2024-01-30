import 'package:flutter/material.dart';
import 'package:groupup/core/bottom_sheet/gp_modal_bottom_sheet.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/constants/design-system.dart';
import 'package:groupup/core/utils/icons/gp_icons.dart';
import 'package:groupup/core/widgets/icons/gp_icon.dart';
import 'package:groupup/modules/groups/components/add_bottom_sheet.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/mix_panel_provider.dart';

class AddProject extends StatelessWidget {
  const AddProject({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Provider.of<MixPanelProvider>(context, listen: false)
            .logEvent(eventName: 'Add Project Button');
        gpModalBottomSheet(
          context,
          context.screenHeight * 0.35,
          const AddBottomSheet(),
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
