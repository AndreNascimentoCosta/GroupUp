import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';

class ProfilePictureAdd extends StatelessWidget {
  const ProfilePictureAdd({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        CircleAvatar(
          radius: MediaQuery.of(context).size.height * 0.06,
          backgroundColor: const Color(0XFFE1E1E1),
          child: SvgPicture.asset(
            'assets/icons/profile_picture.svg',
            color: Colors.white,
            height: Insets.l * 2,
            width: Insets.l * 2,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.075,
            left: MediaQuery.of(context).size.height * 0.075,
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.0475,
            width: MediaQuery.of(context).size.height * 0.0475,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: 4,
              ),
              borderRadius: BorderRadius.circular(Insets.xl),
              color: kPrimaryColor,
            ),
            child: ImageIcon(
              const AssetImage(
                'assets/icons/plus_profile.png',
              ),
              color: Colors.white,
              size: MediaQuery.of(context).size.height * 0.035,
            ),
          ),
        ),
      ],
    );
  }
}
