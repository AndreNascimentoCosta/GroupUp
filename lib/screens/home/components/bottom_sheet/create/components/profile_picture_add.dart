import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/widgets/texts/large_body.dart';
import 'package:groupup/design-system.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePictureAdd extends StatefulWidget {
  const ProfilePictureAdd({super.key});

  @override
  State<ProfilePictureAdd> createState() => _ProfilePictureAddState();
}

class _ProfilePictureAddState extends State<ProfilePictureAdd> {
  File? image;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ButtonCommonStyle(
      onPressed: () {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Insets.m),
          ),
          builder: (context) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Wrap(
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.15,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: kDefaultPadding * 1.5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ButtonCommonStyle(
                                  onPressed: () {
                                    pickImage(ImageSource.gallery);
                                  },
                                  child: const LargeBody(
                                    text: 'Choose from gallery',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(height: Insets.l * 1.5),
                                ButtonCommonStyle(
                                  onPressed: () {
                                    pickImage(ImageSource.camera);
                                  },
                                  child: const LargeBody(
                                    text: 'Take photo',
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                            ),
                          )),
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          CircleAvatar(
            radius: MediaQuery.of(context).size.height * 0.06,
            backgroundColor: const Color(0XFFE1E1E1),
            child: image != null
                ? ClipOval(
                    child: Image.file(
                      image!,
                      fit: BoxFit.cover,
                      height: 120,
                      width: 120,
                    ),
                  )
                : SvgPicture.asset(
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
      ),
    );
  }
}
