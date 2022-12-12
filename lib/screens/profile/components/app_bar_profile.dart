import 'package:flutter/material.dart';
import 'package:groupup/styles/standard_text.dart';

class AppBarProfile extends StatelessWidget with PreferredSizeWidget {
  const AppBarProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      title: StandardTextStyle(
        text: 'angusmac_41',
        fontFamily: 'Montserrat-Bold',
        fontSize: 20,
      ),
      centerTitle: false,
      actions: [
        Align(
          alignment: Alignment.bottomCenter,
          child: IconButton(
              onPressed: () {},
              iconSize: 25,
              color: Colors.black,
              padding: const EdgeInsets.only(right: 20),
              icon: const ImageIcon(AssetImage('assets/icons/ellipsis.png'))),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(55);
}