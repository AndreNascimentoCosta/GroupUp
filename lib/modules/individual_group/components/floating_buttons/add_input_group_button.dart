import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/constants/design-system.dart';
import 'package:groupup/core/utils/icons/gp_icons.dart';
import 'package:groupup/models/home_view_model.dart';
import 'package:groupup/core/providers/add_input_provider.dart';
import 'package:groupup/modules/individual_group/components/deny_add_input_dialog.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/providers/mix_panel_provider.dart';

class AddInputGroupButton extends StatefulWidget {
  const AddInputGroupButton({
    required this.homeViewModel,
    this.backgroundColor = GPColors.primaryColor,
    this.icon = GPIcons.plus,
  });

  final HomeViewModel homeViewModel;
  final Color backgroundColor;
  final String icon;

  @override
  State<AddInputGroupButton> createState() => _AddInputGroupButtonState();
}

class _AddInputGroupButtonState extends State<AddInputGroupButton> {
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return SizedBox(
      height: 75,
      width: 75,
      child: FittedBox(
        child: ValueListenableBuilder(
          valueListenable: widget.homeViewModel.isEditing,
          builder: ((context, value, child) {
            return FloatingActionButton(
              heroTag: 'btn3',
              highlightElevation: 0,
              onPressed: () {
                Provider.of<MixPanelProvider>(context, listen: false)
                    .logEvent(eventName: 'Confirm Add Input');
                final group =
                    Provider.of<IndividualGroupProvider>(context, listen: false)
                        .group;
                Provider.of<AddInputProvider>(context, listen: false).clean();
                if (group == null) return;
                final participantsSumValue =
                    group.participantsData.map((element) {
                  return element.sumData.value;
                }).toList();
                participantsSumValue.sort((a, b) => b.compareTo(a));
                final isTied = participantsSumValue
                        .where(
                            (element) => element == participantsSumValue.first)
                        .length >
                    1;
                final isNotTied = participantsSumValue
                        .where(
                            (element) => element == participantsSumValue.first)
                        .length ==
                    1;
                if (group.maxParticipants > 1 &&
                    group.maxParticipants > group.participants.length) {
                  denyAddInputDialog(context,
                      appLocalizations.cantAddDataWhenNotEveryoneHasJoined);
                } else if (participantsSumValue.length > 1 &&
                    isTied &&
                    group.endDate!.isBefore(
                      DateTime.now().subtract(
                        const Duration(
                          days: 2,
                        ),
                      ),
                    )) {
                  denyAddInputDialog(
                      context, appLocalizations.cantAddDataInValidationPeriod);
                } else if (group.endDate!.isBefore(
                      DateTime.now().subtract(
                        const Duration(
                          days: 1,
                        ),
                      ),
                    ) &&
                    isNotTied) {
                  denyAddInputDialog(
                      context, appLocalizations.cantAddDataInValidationPeriod);
                } else {
                  Provider.of<AddInputProvider>(context, listen: false)
                      .addInputBottomSheet(context);
                }
              },
              backgroundColor: widget.backgroundColor,
              elevation: 0,
              child: SvgPicture.asset(
                widget.icon,
                height: Insets.l * 1.5,
                width: Insets.l * 1.5,
              ),
            );
          }),
        ),
      ),
    );
  }
}
