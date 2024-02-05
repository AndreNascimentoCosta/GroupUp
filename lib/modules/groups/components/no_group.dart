import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/bottom_sheet/gp_modal_bottom_sheet.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/utils/icons/gp_icons.dart';
import 'package:groupup/core/widgets/buttons/button_common_style.dart';
import 'package:groupup/core/constants/design_system.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';
import 'package:groupup/modules/groups/components/groups_events.dart';
import 'package:groupup/modules/groups/components/stats_no_group.dart';
import 'package:groupup/core/providers/create_group_provider.dart';
import 'package:groupup/modules/create_group_page_view/screens/create_group_page_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NoGroup extends StatelessWidget {
  const NoGroup({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: SizedBox(
          height: context.screenHeight * 0.725,
          child: Column(
            children: [
              ButtonCommonStyle(
                onPressed: () {
                  Provider.of<CreateGroupProvider>(context, listen: false)
                      .clean();
                  Provider.of<MixPanelProvider>(context, listen: false)
                      .logEvent(
                    eventName: GroupsEvents.pressCreateGroupBottomSheet.value,
                  );
                  gpModalBottomSheet(
                    context,
                    context.screenHeight * 0.7,
                    const CreateGroupPageView(),
                  );
                },
                child: Row(
                  children: [
                    DottedBorder(
                      borderType: BorderType.Circle,
                      color: GPColors.secondaryColor,
                      dashPattern: const [5, 5],
                      child: const SizedBox(
                        height: 70,
                        width: 70,
                        child: ImageIcon(
                          AssetImage(
                            GPIcons.plusPicture,
                          ),
                          color: GPColors.secondaryColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: kDefaultPadding,
                      ),
                      child: GPTextBody(
                        text: appLocalizations.newGroup,
                        color: GPColors.secondaryColor,
                        fontSize: 18,
                      ),
                    ),
                    const Flexible(child: StatsNoGroup()),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: Insets.xl * 1.5),
                child: GPTextBody(
                  text: appLocalizations.createOrJoinAGroup,
                  color: GPColors.secondaryColor,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
