import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/group.dart';
import 'package:groupup/models/home_view.dart';
import 'package:groupup/models/participant.dart';
import 'package:groupup/models/show_group.dart';
import 'package:groupup/screens/add_input/screens/add_input_screen.dart';
import '../../../../constants.dart';

class CalendarScreenButton extends StatefulWidget {
  const CalendarScreenButton({
    required this.homeViewModel,
    required this.groupModel,
    required this.participant,
    required this.showGroup,
    this.backgroundColor = kPrimaryColor,
    this.icon = 'assets/icons/plus.svg',
  });

  final HomeViewModel homeViewModel;
  final GroupModel groupModel;
  final Participant participant;
  final Color backgroundColor;
  final String icon;
  final ShowGroupModel showGroup;

  @override
  State<CalendarScreenButton> createState() => _CalendarScreenButtonState();
}

class _CalendarScreenButtonState extends State<CalendarScreenButton> {
  @override
  Widget build(BuildContext context) {
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddInputScreen(
                        groupModel: widget.groupModel,
                        homeViewModel: widget.homeViewModel,
                        participant: widget.participant,
                        showGroup: widget.showGroup,
                      ),
                    ));
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
  }
}
