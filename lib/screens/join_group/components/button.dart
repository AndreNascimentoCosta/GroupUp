import 'package:flutter/material.dart';
import 'package:groupup/core/bottom_sheet/gp_modal_bottom_sheet.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/providers/join_group_provider.dart';
import 'package:groupup/screens/home/components/home_button.dart';
import 'package:groupup/screens/join_group/pages/join_page_view.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:provider/provider.dart';

class JoinGroupButton extends StatelessWidget {
  const JoinGroupButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ButtonCommonStyle(
      onPressed: () {
        Provider.of<JoinGroupProvider>(
          context,
          listen: false,
        ).clean();
        Provider.of<MixPanelProvider>(
          context,
          listen: false,
        ).logEvent(
          eventName: 'Join Group Button',
        );
        gpModalBottomSheet(
          context,
          420,
          const JoinPageView(),
        );
      },
      child: const HomeButton(
        isJoinButton: true,
      ),
    );
  }
}
