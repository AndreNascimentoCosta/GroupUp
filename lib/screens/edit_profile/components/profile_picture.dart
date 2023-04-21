import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/constants/design-system.dart';
import 'package:groupup/core/utils/icons/gp_icons.dart';
import 'package:groupup/core/widgets/icons/gp_icon.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        const CircleAvatar(
          radius: 70,
          backgroundColor: GPColors.lightGray,
          child: GPIcon(
            GPIcons.profilePicture,
            color: GPColors.white,
            height: Insets.l * 3,
            width: Insets.l * 3,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              top: kDefaultPadding * 4.5, left: kDefaultPadding * 4.5),
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
                GPIcons.plusProfile2,
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
