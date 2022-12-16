import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';

class ProfilePictureAdd extends StatelessWidget {
  const ProfilePictureAdd({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Color(0XFFE1E1E1),
              child: ImageIcon(
                AssetImage(
                  'assets/icons/profile_picture.png',
                ),
                color: Colors.white,
                size: 40,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: kDefaultPadding * 3.5, left: kDefaultPadding * 3.5),
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 4,
                  ),
                  borderRadius: BorderRadius.circular(Insets.xl),
                  color: kPrimaryColor,
                ),
                child: const ImageIcon(
                  AssetImage(
                    'assets/icons/plus_add.png',
                  ),
                  color: Colors.white,
                  size: 10,
                ),
              ),
            ),
          ],
        );
  }
}