import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/utils/icons/gp_icons.dart';
import 'package:groupup/core/widgets/icons/gp_icon.dart';
import 'package:groupup/core/widgets/texts/gp_text_header.dart';
import 'package:groupup/core/constants/design-system.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/providers/edit_group_objective_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppBarEditGroupObjective extends StatelessWidget
    implements PreferredSizeWidget {
  const AppBarEditGroupObjective({super.key});

  @override
  Widget build(BuildContext context) {
    final editGroupObjectiveProvider =
        Provider.of<EditGroupObjectiveProvider>(context);
    final appLocalizations = AppLocalizations.of(context)!;
    final group = Provider.of<IndividualGroupProvider>(context).group;
    if (group == null) {
      return const SizedBox();
    }
    return SafeArea(
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.centerStart,
            children: [
              Container(
                width: context.screenWidth,
                height: 50,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 0.2,
                      color: Color(0xffa1a1a1),
                    ),
                  ),
                ),
                alignment: AlignmentDirectional.center,
                child: GPTextHeader(text: appLocalizations.groupObjective),
              ),
              ButtonCommonStyle(
                onPressed: () {
                  if (editGroupObjectiveProvider
                          .groupObjectiveController.text ==
                      group.objective) {
                    Provider.of<MixPanelProvider>(context, listen: false).logEvent(
                        eventName:
                            'Back to Edit Profile Screen from Edit Group Objective Screen');
                    Navigator.pop(context);
                  } else {
                    Provider.of<MixPanelProvider>(context, listen: false).logEvent(
                        eventName:
                            'Discard Changes from Edit Group Objective Screen');
                    editGroupObjectiveProvider.confirmDiscard(context);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: kDefaultPadding),
                  child: GestureDetector(
                    child: Container(
                      color: GPColors.transparent,
                      width: Insets.l * 3,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GPIcon(
                            GPIcons.arrowDown,
                            color: GPColors.black,
                            height: Insets.l * 1.25,
                            width: Insets.l * 1.25,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: kDefaultPadding,
                child: Padding(
                  padding: const EdgeInsets.only(left: kDefaultPadding),
                  child: ButtonCommonStyle(
                    onPressed: editGroupObjectiveProvider.done(
                        context, group.objective, group.id),
                    child: GPTextHeader(
                      text: appLocalizations.done,
                      color: editGroupObjectiveProvider.done(
                                  context, group.objective, group.id) ==
                              null
                          ? GPColors.secondaryColor
                          : GPColors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
