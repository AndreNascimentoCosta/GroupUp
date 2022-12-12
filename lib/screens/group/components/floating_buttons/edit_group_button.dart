import 'package:flutter/material.dart';
import 'package:groupup/models/home_view.dart';
import '../../../../constants.dart';

class EditGroupButton extends StatefulWidget {
  EditGroupButton({required this.homeViewModel, this.backgroundColor = kPrimaryColor});

  final HomeViewModel homeViewModel;
  Color backgroundColor;

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
                  child: const ImageIcon(
                    AssetImage(
                      'assets/icons/exit.png',
                    ),
                    size: 25,
                  ),
                );
              }
              return FloatingActionButton(
                heroTag: 'btn4',
                onPressed: widget.homeViewModel.switchEdit,
                backgroundColor: widget.backgroundColor,
                highlightElevation: 0,
                elevation: 0,
                child: const ImageIcon(
                  AssetImage(
                    'assets/icons/edit.png',
                  ),
                  size: 25,
                ),
              );
            }),
      ),
    );
  }
}