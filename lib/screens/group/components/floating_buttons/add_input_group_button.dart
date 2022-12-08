import 'package:flutter/material.dart';
import 'package:groupup/models/home_view.dart';

import '../../../../constants.dart';

class AddInputGroupButton extends StatefulWidget {
  const AddInputGroupButton({required this.homeViewModel});

  final HomeViewModel homeViewModel;

  @override
  State<AddInputGroupButton> createState() => _AddInputGroupButtonState();
}

class _AddInputGroupButtonState extends State<AddInputGroupButton> {
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
                onPressed: () {},
                backgroundColor: widget.homeViewModel.isEditing.value
                    ? const Color(0x5946E297)
                    : kPrimaryColor,
                elevation: 0,
                child: const ImageIcon(
                  AssetImage(
                    'assets/icons/plus_home.png',
                  ),
                  size: 30,
                ),
              );
            })),
      ),
    );
  }
}
