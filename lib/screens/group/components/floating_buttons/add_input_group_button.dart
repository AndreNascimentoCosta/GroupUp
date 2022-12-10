import 'package:flutter/material.dart';
import 'package:groupup/models/group.dart';
import 'package:groupup/models/home_view.dart';
import 'package:groupup/screens/add_input/add_input_screen.dart';
import '../../../../constants.dart';

class AddInputGroupButton extends StatefulWidget {
  const AddInputGroupButton(
      {required this.homeViewModel, required this.groupModel});

  final HomeViewModel homeViewModel;
  final GroupModel groupModel;

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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddInputScreen(
                        groupModel: widget.groupModel,
                        homeViewModel: widget.homeViewModel,
                      ),
                    ));
              },
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
          }),
        ),
      ),
    );
  }
}
