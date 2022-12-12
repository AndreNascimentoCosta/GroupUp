import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/styles/standard_text.dart';

class EditProfile extends StatelessWidget {
  EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        right: 25,
        left: 20,
      ),
      height: 50.0,
      width: 180,
      decoration: BoxDecoration(
        color: const Color(0xFFEBEBEB),
        borderRadius: BorderRadius.circular(kDefaultPadding * 0.25),
      ),
      alignment: Alignment.center,
      child: const Text(
        'Edit Profile',
        style: TextStyle(
          fontFamily: 'Montserrat-SemiBold',
          fontSize: 18,
          color: Colors.black
        ),
      ),
    );
  }
}
