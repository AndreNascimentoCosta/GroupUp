import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        right: Insets.xl,
        left: Insets.xl,
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
          fontSize: TextSize.lBody,
          color: Colors.black
        ),
      ),
    );
  }
}
