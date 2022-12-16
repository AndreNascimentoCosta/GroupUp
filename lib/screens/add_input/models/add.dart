import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/styles/button.dart';

class Add extends StatelessWidget {
  const Add({super.key});

  @override
  Widget build(BuildContext context) {
    return ButtonCommonStyle(
      onPressed: () {},
      child: Container(
        alignment: Alignment.center,
        height: 40,
        width: 50,
        decoration: BoxDecoration(
            border: Border.all(color: kPrimaryColor),
            borderRadius: BorderRadius.circular(Insets.s),
            color: kPrimaryColor,
            boxShadow: const [
              BoxShadow(
                color: kSecondaryColor,
                blurRadius: 1,
                spreadRadius: 1,
                offset: Offset(.5, 1),
              )
            ]),
        child: const ImageIcon(
          AssetImage(
            'assets/icons/plus_home.png',
          ),
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }
}
