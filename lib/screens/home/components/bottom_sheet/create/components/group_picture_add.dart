import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/widgets/texts/large_body.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/home/components/bottom_sheet/create/create_group_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class GroupPictureAdd extends StatefulWidget {
  const GroupPictureAdd({super.key});

  @override
  State<GroupPictureAdd> createState() => _GroupPictureAddState();
}

class _GroupPictureAddState extends State<GroupPictureAdd> {
  File? image;

  Future pickImage(ImageSource source) async {
    Navigator.pop(context);
    try {
      final image =
          await ImagePicker().pickImage(source: source, imageQuality: 60);
      if (image == null) return;

      final imageTemporary = File(image.path);

      if (!mounted) return;
      Provider.of<CreateGroupProvider>(context, listen: false).image =
          imageTemporary;
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
                          height: MediaQuery.of(context).size.height * 0.185,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: kDefaultPadding * 1.75),
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
                                const SizedBox(height: Insets.l * 1.75),
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
                    'assets/icons/profile_picture_add.svg',
                    color: Colors.white,
                    height: Insets.l * 2,
                    width: Insets.l * 2,
                  ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.081,
              left: MediaQuery.of(context).size.height * 0.081,
            ),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.04,
              width: MediaQuery.of(context).size.height * 0.04,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.transparent,
                  width: 4,
                ),
                borderRadius: BorderRadius.circular(Insets.xl),
                color: kPrimaryColor,
              ),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
                width: MediaQuery.of(context).size.height * 0.04,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: MediaQuery.of(context).size.height * 0.032,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
