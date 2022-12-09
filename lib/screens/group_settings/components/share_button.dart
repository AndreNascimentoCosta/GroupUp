import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/styles/button_style.dart';

class ShareButton extends StatelessWidget {
  const ShareButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ButtonCommonStyle(
      child: Container(
        height: 50,
        width: 150,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          border: Border.all(color: kPrimaryColor),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: const [
            SizedBox(
              width: 100,
              child: Text(
                '846264',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Montserrat-Medium',
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: ImageIcon(
                AssetImage(
                  'assets/icons/share.png',
                ),
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      onPressed: () {},
    );
  }
}
