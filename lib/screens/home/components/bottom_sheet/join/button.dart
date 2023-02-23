import 'package:flutter/material.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/core/providers/join_group_provider.dart';
import 'package:groupup/screens/home/components/home_button.dart';
import 'package:groupup/screens/home/components/bottom_sheet/join/join_page_view.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:provider/provider.dart';

class JoinGroupButton extends StatelessWidget {
  const JoinGroupButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ButtonCommonStyle(
      onPressed: () {
        Provider.of<JoinGroupProvider>(context, listen: false).clean();
        Provider.of<MixPanelProvider>(context, listen: false)
            .logEvent(eventName: 'Join Group Button');
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Insets.m),
          ),
          builder: (context) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Wrap(
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      SizedBox(
                        height: 420,
                        child: JoinPageView(),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
      child: const HomeButton(isGreen: true),
    );
  }
}
