import 'package:flutter/material.dart';
import 'package:groupup/core/bottom_sheet/gp_modal_bottom_sheet.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/providers/create_group_provider.dart';
import 'package:groupup/screens/create_group/create_page_view.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/screens/home/components/home_button.dart';
import 'package:provider/provider.dart';

class CreateGroupButton extends StatelessWidget {
  const CreateGroupButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ButtonCommonStyle(
      onPressed: () {
        Provider.of<CreateGroupProvider>(
          context,
          listen: false,
        ).clean();
        Provider.of<MixPanelProvider>(
          context,
          listen: false,
        ).logEvent(
          eventName: 'Create Group Button',
        );
        gpModalBottomSheet(
          context,
          context.screenHeight * 0.7,
          const CreatePageView(),
        );
      },
      child: const HomeButton(
        isJoinButton: false,
      ),
    );
  }
}
