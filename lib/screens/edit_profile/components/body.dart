import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/providers/storage.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/widgets/texts/large_body.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/edit_profile/components/profile_picture_add.dart';
import 'package:groupup/screens/edit_profile/edit_fields/edit_name/edit_profile_name.dart';
import 'package:groupup/screens/home/components/bottom_sheet/sign_up/auth_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProfileBody extends StatefulWidget {
  const EditProfileBody({super.key});

  @override
  State<EditProfileBody> createState() => _EditProfileBodyState();
}

class _EditProfileBodyState extends State<EditProfileBody> {
  Future pickImage(ImageSource source) async {
    Navigator.pop(context);
    final storage = Provider.of<StorageProvider>(context, listen: false);
    try {
      final profilePicture = await ImagePicker().pickImage(
        source: source,
        imageQuality: 15,
      );
      if (profilePicture == null) return;

      storage.profilePicture = File(profilePicture.path);
      if (!mounted) return;
      await storage.uploadProfilePicture(context);
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: Insets.l * 1.5),
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
                    final userProfilePicture = user?.profilePicture;

                    final profilePicture = storage.profilePicture;

                    if (profilePicture != null) {
                      return Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(Insets.l * 6),
                            child: Image.file(
                              profilePicture,
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
                    if (userProfilePicture?.isNotEmpty == true &&
                        userProfilePicture != null) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(Insets.l * 6),
                        child: CachedNetworkImage(
                          imageUrl: userProfilePicture,
                          fadeInDuration: const Duration(milliseconds: 100),
                          height: Insets.l * 6,
                          width: Insets.l * 6,
                          fit: BoxFit.cover,
                        ),
                      );
                    }
                    return SvgPicture.asset(
                      'assets/icons/profile_picture_add.svg',
                      color: Colors.white,
                      height: Insets.l * 3,
                      width: Insets.l * 3,
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
          const SizedBox(height: kDefaultPadding * 2),
          ButtonCommonStyle(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditNameScreen(),
                ),
              );
            },
            child: Container(
              height: 50,
              width: 400,
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: kSecondaryColor,
                    width: 0.5,
                  ),
                  bottom: BorderSide(
                    color: kSecondaryColor,
                    width: 0.5,
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 110,
                    child: Padding(
                      padding: EdgeInsets.only(left: kDefaultPadding * 0.5),
                      child: LargeBody(text: 'Name'),
                    ),
                  ),
                  const SizedBox(width: Insets.l * 2),
                  StaticText(
                      text: user?.name ?? 'Name', fontSize: TextSize.lBody),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
