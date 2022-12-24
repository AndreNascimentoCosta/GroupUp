import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/home_view.dart';
import '../../../../constants.dart';

class EditGroupButton extends StatefulWidget {
  const EditGroupButton({required this.homeViewModel, this.backgroundColor = kPrimaryColor});

  final HomeViewModel homeViewModel;
  final Color backgroundColor;

  @override
  State<EditGroupButton> createState() => _EditGroupButtonState();
}

class _EditGroupButtonState extends State<EditGroupButton> {
  @override
  Widget build(BuildContext context) {
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
              return FloatingActionButton(
                heroTag: 'btn4',
                onPressed: widget.homeViewModel.switchEdit,
                backgroundColor: widget.backgroundColor,
                highlightElevation: 0,
                elevation: 0,
                child: SvgPicture.asset(
                    'assets/icons/edit.svg',
                  height: Insets.xl,
                  width: Insets.xl,
                ),
              );
            }),
      ),
    );
  }
}
