import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/providers/storage_provider.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/widgets/texts/large_body.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/edit_profile/components/profile_picture_add.dart';
import 'package:groupup/screens/edit_profile/edit_fields/edit_name/edit_profile_name.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/providers/mix_panel_provider.dart';

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
      debugPrint('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;
    final appLocalizations = AppLocalizations.of(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenHeight < 800 || screenWidth < 350;
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
                  Provider.of<MixPanelProvider>(context, listen: false)
                      .logEvent(
                          eventName:
                              'Edit Profile Picture - Choose from Gallery');
                  pickImage(ImageSource.gallery);
                },
                onPressedCamera: () {
                  Provider.of<MixPanelProvider>(context, listen: false)
                      .logEvent(eventName: 'Edit Profile Picture - Take Photo');
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
                                child: CircularProgressIndicator.adaptive(),
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
                        child: Container(
                          height: Insets.l * 6,
                          width: Insets.l * 6,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                userProfilePicture,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    }
                    return SvgPicture.asset(
                      'assets/icons/profile_picture_add.svg',
                      color: Colors.white,
                      height: isSmallScreen ? Insets.l * 2 : Insets.l * 3,
                      width: isSmallScreen ? Insets.l * 2 : Insets.l * 3,
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: isSmallScreen
                      ? screenHeight * 0.085
                      : screenHeight * 0.085,
                  left:
                      isSmallScreen ? screenWidth * 0.15 : screenWidth * 0.175,
                ),
                child: Container(
                  height: isSmallScreen ? 22.5 : 30,
                  width: isSmallScreen ? 22.5 : 30,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.transparent,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(Insets.l),
                    color: kPrimaryColor,
                  ),
                  child: SizedBox(
                    height: isSmallScreen ? 22.5 : 30,
                    width: isSmallScreen ? 22.5 : 30,
                    child: Icon(
                      Icons.edit_rounded,
                      color: Colors.white,
                      size: isSmallScreen ? 10 : 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: kDefaultPadding * 2),
          ButtonCommonStyle(
            onPressed: () {
              Provider.of<MixPanelProvider>(context, listen: false)
                  .logEvent(eventName: 'Edit Name Screen');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditNameScreen(),
                  settings: const RouteSettings(name: 'Edit_Name'),
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
                  SizedBox(
                    width: 110,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: kDefaultPadding * 0.5),
                      child: LargeBody(text: appLocalizations.name),
                    ),
                  ),
                  const SizedBox(width: Insets.l * 2),
                  SizedBox(
                    width: isSmallScreen
                        ? MediaQuery.of(context).size.width * 0.4
                        : MediaQuery.of(context).size.width * 0.5,
                    child: StaticText(
                      text: Characters(user?.name ?? appLocalizations.name)
                          .replaceAll(Characters(''), Characters('\u{200B}'))
                          .toString(),
                      overflow: TextOverflow.ellipsis,
                      fontSize: TextSize.lBody,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
