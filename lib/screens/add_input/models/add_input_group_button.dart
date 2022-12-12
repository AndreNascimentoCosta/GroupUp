import 'package:flutter/material.dart';
import 'package:groupup/models/group.dart';
import 'package:groupup/models/home_view.dart';
import 'package:groupup/screens/add_input/screens/add_input_screen.dart';
import '../../../../constants.dart';

class AddInputGroupButton extends StatefulWidget {
  AddInputGroupButton({
    required this.homeViewModel,
    required this.groupModel,
    this.backgroundColor = kPrimaryColor,
    this.icon = 'assets/icons/plus_home.png',
  });

  final HomeViewModel homeViewModel;
  final GroupModel groupModel;
  Color backgroundColor;
  String icon;

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
              highlightElevation: 0,
              onPressed: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => AddInputScreen(
                //         groupModel: widget.groupModel,
                //         homeViewModel: widget.homeViewModel,
                //       ),
                //     ));
              },
              backgroundColor: widget.homeViewModel.isEditing.value
                  ? const Color(0x5946E297)
                  : widget.backgroundColor,
              elevation: 0,
              child: ImageIcon(
                AssetImage(
                  widget.icon,
                ),
                size: 30,
              ),
            );
          }),
        ),
      ),
    );
  }
}
