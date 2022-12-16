import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/styles/button.dart';
import 'package:groupup/styles/text.dart';

class ShareButton extends StatelessWidget {
  const ShareButton({required this.onPressed});

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ButtonCommonStyle(
      onPressed: onPressed,
      child: Container(
        height: 50,
        width: 120,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(Insets.s),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              spreadRadius: 1,
              blurRadius: 2,
              color: kSecondaryColor
            )
          ]
        ),
        child: Row(
          children: const [
            SizedBox(
              width: 80,
              child: StandardTextStyle(
                text: '846264',
                textAlign: TextAlign.center,
                fontSize: TextSize.lBody,
              ),
            ),
            Expanded(
                child: Icon(
              Icons.ios_share_rounded,
              color: Colors.black,
              size: 22,
            )),
          ],
        ),
      ),
    );
  }
}
