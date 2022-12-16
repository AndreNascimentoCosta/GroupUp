import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            const CircleAvatar(
              radius: 70,
              backgroundColor: Color(0XFFE1E1E1),
              child: ImageIcon(
                AssetImage(
                  'assets/icons/profile_picture.png',
                ),
                color: Colors.white,
                size: 60,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: kDefaultPadding * 4.5, left: kDefaultPadding * 4.5),
              child: Container(
                height: 50,
                width: 50,
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
                    'assets/icons/plus_edit.png',
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