import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/design-system.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            CircleAvatar(
              radius: 70,
              backgroundColor: const Color(0XFFE1E1E1),
              child: SvgPicture.asset(
                  'assets/icons/profile_picture.svg',
                color: GPColors.white,
                height: Insets.l * 3,
                width: Insets.l * 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: kDefaultPadding * 4.5, left: kDefaultPadding * 4.5),
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: GPColors.white,
                    width: 4,
                  ),
                  borderRadius: BorderRadius.circular(Insets.xl),
                  color: GPColors.primaryColor,
                ),
                child: const ImageIcon(
                  AssetImage(
                    'assets/icons/plus_profile_2.png',
                  ),
                  color: GPColors.white,
                  size: 30,
                ),
              ),
            ),
          ],
        );
  }
}