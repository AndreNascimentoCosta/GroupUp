import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/providers/storage.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/widgets/texts/large_body.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/edit_profile/components/profile_picture_add.dart';
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
          Stack(
            alignment: Alignment.topCenter,
            children: [
              ProfilePictureAdd(
                onPressedGallery: () {
                  pickImage(ImageSource.gallery);
                },
                onPressedCamera: () {
                  pickImage(ImageSource.camera);
                },
                child: Builder(
                  builder: (context) {
                    final storage = Provider.of<StorageProvider>(context);


                    if (image != null) {
                      return Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(Insets.l * 6),
                            child: Image.file(
                              image!,
                              height: Insets.l * 6,
                              width: Insets.l * 6,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Visibility(
                            visible: storage.isLoading,
                            child: Container(
                              height: Insets.l * 6,
                              width: Insets.l * 6,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(Insets.l * 6),
                                ),
                                color: Colors.black54,
                              ),
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: kPrimaryColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    return SvgPicture.asset(
                      'assets/icons/profile_picture_add.svg',
                      color: Colors.white,
                      height: Insets.l * 2.5,
                      width: Insets.l * 2.5,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: kDefaultPadding * 3.85, left: kDefaultPadding * 3.85),
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.transparent,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(Insets.l),
                    color: kPrimaryColor,
                  ),
                  child: const SizedBox(
                    height: 30,
                    width: 30,
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ),
              ),
            ],
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
