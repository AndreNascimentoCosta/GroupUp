import 'package:flutter/material.dart';
import 'package:groupup/styles/standard_text.dart';

class HomeButton extends StatelessWidget {
  HomeButton({required this.isGreen});

  final bool isGreen;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        right: isGreen ? 25 : 15,
        left: 20,
      ),
      height: 80.0,
      decoration: BoxDecoration(
        color: isGreen ? const Color(0xFFEBEBEB) : const Color(0xFF46E297),
        borderRadius: BorderRadius.circular(20),
      ),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          StandardTextStyle(
            text: isGreen ? 'Join a group' : 'Create a new group',
            fontFamily: 'Montserrat-SemiBold',
            fontSize: 20,
            color: isGreen ? Colors.black : Colors.white,
          ),
          const Spacer(),
          Image.asset(
            isGreen
                ? 'assets/icons/arrow_right.png'
                : 'assets/icons/plus_home.png',
            height: isGreen ? 26.0 : 32.67,
            width: isGreen ? 15.0 : 32.67,
          ),
        ],
      ),
    );
  }
}