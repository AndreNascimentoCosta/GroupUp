import 'package:flutter/material.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/group.dart';
import 'package:groupup/models/home_view.dart';
import 'package:groupup/screens/add_input/components/add_input.dart';
import '../../../../constants.dart';

class AddInputGroupButton extends StatefulWidget {
  const AddInputGroupButton({
    required this.homeViewModel,
    required this.groupModel,
    this.backgroundColor = kPrimaryColor,
    this.icon = 'assets/icons/plus_home.png',
  });

  final HomeViewModel homeViewModel;
  final GroupModel groupModel;
  final Color backgroundColor;
  final String icon;

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
                showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(Insets.m),
                        ),
                        builder: (context) {
                          return Padding(
                            padding: MediaQuery.of(context).viewInsets,
                            child: Wrap(
                              children: <Widget>[
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    SizedBox(
                                      height: 220,
                                      child: AddInput(),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        });
              },
              backgroundColor: widget.backgroundColor,
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
