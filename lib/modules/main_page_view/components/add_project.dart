import 'package:flutter/material.dart';
import 'package:groupup/core/bottom_sheet/gp_modal_bottom_sheet.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/providers/create_group_provider.dart';
import 'package:groupup/core/providers/join_group_provider.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/constants/design_system.dart';
import 'package:groupup/core/utils/icons/gp_icons.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/widgets/buttons/group_action_button.dart';
import 'package:groupup/core/widgets/icons/gp_icon.dart';
import 'package:groupup/modules/create_group_page_view/screens/create_group_page_view.dart';
import 'package:groupup/modules/join_group/screens/join_group_page_view.dart';
import 'package:groupup/modules/main_page_view/components/main_page_view_events.dart';
import 'package:provider/provider.dart';

class AddProject extends StatelessWidget {
  const AddProject({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Provider.of<MixPanelProvider>(context, listen: false)
            .logEvent(eventName: MainPageViewEvents.addProjectButton.value);
        gpModalBottomSheet(
          context,
          context.screenHeight * 0.35,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Column(
              children: [
                SizedBox(
                  height: context.isSmallScreen
                      ? context.screenHeight * 0.05
                      : context.screenHeight * 0.055,
                ),
                ButtonCommonStyle(
                  onPressed: () {
                    Provider.of<JoinGroupProvider>(
                      context,
                      listen: false,
                    ).clean();
                    Provider.of<MixPanelProvider>(
                      context,
                      listen: false,
                    ).logEvent(
                      eventName: MainPageViewEvents.pressJoinGroup.value,
                    );
                    gpModalBottomSheet(
                      context,
                      420,
                      const JoinGroupPageView(),
                    );
                  },
                  child: const GroupActionButton(
                    isJoinButton: true,
                  ),
                ),
                SizedBox(
                  height: context.isSmallScreen
                      ? context.screenHeight * 0.025
                      : context.screenHeight * 0.035,
                ),
                ButtonCommonStyle(
                  onPressed: () {
                    Provider.of<CreateGroupProvider>(
                      context,
                      listen: false,
                    ).clean();
                    Provider.of<MixPanelProvider>(
                      context,
                      listen: false,
                    ).logEvent(
                      eventName: MainPageViewEvents.pressCreateGroup.value,
                    );
                    gpModalBottomSheet(
                      context,
                      context.screenHeight * 0.7,
                      const CreateGroupPageView(),
                    );
                  },
                  child: const GroupActionButton(),
                ),
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
