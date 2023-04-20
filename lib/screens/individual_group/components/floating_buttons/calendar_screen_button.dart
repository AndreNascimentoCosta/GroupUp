import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/core/bottom_sheet/gp_modal_bottom_sheet.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/constants/design-system.dart';
import 'package:groupup/models/home_view.dart';
import 'package:groupup/screens/individual_group/components/calendar_add_input/add_input.dart';
import 'package:provider/provider.dart';
import '../../../../core/providers/individual_group_provider.dart';
import '../../../../core/providers/mix_panel_provider.dart';

class CalendarScreenButton extends StatefulWidget {
  const CalendarScreenButton({
    required this.homeViewModel,
    this.backgroundColor = GPColors.primaryColor,
    this.icon = 'assets/icons/plus.svg',
  });

  final HomeViewModel homeViewModel;
  final Color backgroundColor;
  final String icon;

  @override
  State<CalendarScreenButton> createState() => _CalendarScreenButtonState();
}

class _CalendarScreenButtonState extends State<CalendarScreenButton> {
  @override
  Widget build(BuildContext context) {
    final group = Provider.of<IndividualGroupProvider>(context).group;
    return Builder(
      builder: (context) {
        if (group == null) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        return SizedBox(
          height: 75,
          width: 75,
          child: FittedBox(
            child: ValueListenableBuilder(
              valueListenable: widget.homeViewModel.isEditing,
              builder: ((context, value, child) {
                final individualGroupProvider =
                    Provider.of<IndividualGroupProvider>(context);
                return FloatingActionButton(
                  heroTag: 'btn3',
                  highlightElevation: 0,
                  onPressed: () {
                    Provider.of<MixPanelProvider>(context, listen: false)
                        .logEvent(eventName: 'Calendar Screen Button');
                    individualGroupProvider.pageIndex == 0
                        ? individualGroupProvider.pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease,
                          )
                        : gpModalBottomSheet(
                            context,
                            220,
                            const AddInput(),
                          );
                  },
                  backgroundColor: widget.homeViewModel.isEditing.value
                      ? const Color(0x5946E297)
                      : widget.backgroundColor,
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
      },
    );
  }
}
