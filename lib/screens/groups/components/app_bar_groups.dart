import 'package:flutter/material.dart';
import 'package:groupup/styles/button_style.dart';
import 'package:groupup/styles/standard_text.dart';
import '../../../models/home_view.dart';

class AppBarGroup extends StatefulWidget with PreferredSizeWidget {
  AppBarGroup({required this.homeViewModel});

  final HomeViewModel homeViewModel;

  State<AppBarGroup> createState() => _AppBarGroupState();

  @override
  Size get preferredSize => const Size.fromHeight(55);
}

class _AppBarGroupState extends State<AppBarGroup> {
  @override
  Widget build(BuildContext context) {
    return buildAppBar();
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      title: StandardTextStyle(
        text: 'Groups',
        fontFamily: 'Montserrat-Bold',
        fontSize: 36,
      ),
      centerTitle: false,
      actions: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: 7,
          ),
          child: Align(
            widthFactor: 1.5,
            alignment: Alignment.bottomLeft,
            child: ButtonCommonStyle(
              onPressed: () {
                widget.homeViewModel.switchEdit();
              },
              padding: const EdgeInsets.only(bottom: 10, right: 80),
              child: StandardTextStyle(
                text: 'Edit',
                fontSize: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
