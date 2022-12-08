import 'package:flutter/material.dart';

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
      title: const Text(
        'Groups',
        style: TextStyle(
          fontFamily: 'Montserrat-Bold',
          fontSize: 36,
          color: Colors.black,
        ),
      ),
      centerTitle: false,
      actions: [
        Align(
          alignment: Alignment.bottomCenter,
          child: IconButton(
            onPressed: () {
              widget.homeViewModel.switchEdit();
            },
            iconSize: 40,
            padding: const EdgeInsets.only(right: 20),
            icon: const Text(
              'Edit',
              style: TextStyle(
                fontFamily: 'Montserrat-SemiBold',
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}