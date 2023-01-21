import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/core/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/home_view.dart';
import 'package:groupup/screens/individual_group/components/calendar_add_input/add_input.dart';
import 'package:provider/provider.dart';
import '../../../../constants.dart';
import '../individual_group_provider.dart';

class CalendarScreenButton extends StatefulWidget {
  const CalendarScreenButton({
    required this.homeViewModel,
    this.backgroundColor = kPrimaryColor,
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
    return Builder(builder: (context) {
      if (group == null) {
        return const Center(
          child: CircularProgressIndicator(color: kPrimaryColor),
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
                  individualGroupProvider.pageIndex == 0
                      ? individualGroupProvider.pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        )
                      : showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(Insets.m),
                          ),
                          builder: (context) {
                            return const BuilderBottomSheet(
                              height: 220,
                              child: AddInput(),
                            );
                          },
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
    });
  }
}
