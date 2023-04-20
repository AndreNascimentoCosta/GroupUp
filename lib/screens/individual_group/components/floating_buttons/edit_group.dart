import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/core/bottom_sheet/gp_modal_bottom_sheet.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/constants/design-system.dart';
import 'package:groupup/models/home_view.dart';
import 'package:groupup/screens/individual_group/components/calendar_add_input/data_history.dart';
import 'package:groupup/screens/individual_group/components/calendar_add_input/data_history_bottom_sheet.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:provider/provider.dart';
import '../../../../core/providers/mix_panel_provider.dart';

class EditAndHistoryGroupButton extends StatefulWidget {
  const EditAndHistoryGroupButton({
    required this.homeViewModel,
    this.backgroundColor = GPColors.primaryColor,
  });

  final HomeViewModel homeViewModel;
  final Color backgroundColor;

  @override
  State<EditAndHistoryGroupButton> createState() =>
      _EditAndHistoryGroupButtonState();
}

class _EditAndHistoryGroupButtonState extends State<EditAndHistoryGroupButton> {
  @override
  Widget build(BuildContext context) {
    final individualGroupProvider =
        Provider.of<IndividualGroupProvider>(context);
    if (individualGroupProvider.group == null) {
      return const CircularProgressIndicator.adaptive();
    }
    final user = Provider.of<AuthProvider>(context).user;
    return SizedBox(
      height: 75,
      width: 75,
      child: FittedBox(
        child: ValueListenableBuilder(
          valueListenable: widget.homeViewModel.isEditing,
          builder: (context, value, child) {
            if (widget.homeViewModel.isEditing.value) {
              return FloatingActionButton(
                heroTag: 'btn5',
                highlightElevation: 0,
                onPressed: widget.homeViewModel.switchEdit,
                backgroundColor: widget.backgroundColor,
                elevation: 0,
                child: SvgPicture.asset(
                  'assets/icons/exit.svg',
                  height: Insets.xl,
                  width: Insets.xl,
                ),
              );
            }
            if (individualGroupProvider.pageIndex == 0) {
              return FloatingActionButton(
                heroTag: 'btn4',
                onPressed: individualGroupProvider.pageIndex == 0
                    ? widget.homeViewModel.switchEdit
                    : () {
                        Provider.of<MixPanelProvider>(context, listen: false)
                            .logEvent(eventName: 'View Data History');
                        gpModalBottomSheet(
                          context,
                          500,
                          DataHistoryBottomSheet(
                            userInputData: individualGroupProvider
                                .group!.participantsData
                                .firstWhere(
                                    (element) => element.uid == user?.id)
                                .inputData,
                          ),
                        );
                      },
                backgroundColor: widget.backgroundColor,
                highlightElevation: 0,
                elevation: 0,
                child: individualGroupProvider.pageIndex == 0
                    ? SvgPicture.asset(
                        'assets/icons/edit.svg',
                        height: Insets.xl,
                        width: Insets.xl,
                      )
                    : const Icon(Icons.history, size: 30),
              );
            } else {
              return DataHistoryButton(
                homeViewModel: widget.homeViewModel,
              );
            }
          },
        ),
      ),
    );
  }
}
