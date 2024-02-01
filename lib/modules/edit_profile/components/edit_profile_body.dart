import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/extensions/gp_navigator_extension.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/providers/storage_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/utils/icons/gp_icons.dart';
import 'package:groupup/core/widgets/buttons/add_picture_button.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/widgets/icons/gp_icon.dart';
import 'package:groupup/core/widgets/loading/gp_loading.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';
import 'package:groupup/core/constants/design-system.dart';
import 'package:groupup/modules/edit_profile/components/edit_profile_events.dart';
import 'package:groupup/modules/edit_profile/edit_fields/edit_name/screens/edit_profile_name_screen.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditProfileBody extends StatefulWidget {
  const EditProfileBody({super.key});

  @override
  State<EditProfileBody> createState() => _EditProfileBodyState();
}

class _EditProfileBodyState extends State<EditProfileBody> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;
    final appLocalizations = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: Insets.l * 1.5),
          Stack(
            alignment: Alignment.topCenter,
            children: [
              AddPicture(
                onPressedGallery: () {
                  Provider.of<MixPanelProvider>(context, listen: false)
                      .logEvent(
                    eventName: EditProfileEvents
                        .editProfilePictureChooseFromGallery.value,
                  );
                  pickImage(ImageSource.gallery);
                },
                onPressedCamera: () {
                  Provider.of<MixPanelProvider>(context, listen: false)
                      .logEvent(
                    eventName:
                        EditProfileEvents.editProfilePictureTakePhoto.value,
                  );
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
                                color: GPColors.black,
                              ),
                              child: const GPLoading(),
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
                    return GPIcon(
                      GPIcons.profilePictureAdd,
                      color: GPColors.white,
                      height:
                          context.isSmallScreen ? Insets.l * 2 : Insets.l * 3,
                      width:
                          context.isSmallScreen ? Insets.l * 2 : Insets.l * 3,
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: context.isSmallScreen
                      ? context.screenHeight * 0.085
                      : context.screenHeight * 0.085,
                  left: context.isSmallScreen
                      ? context.screenWidth * 0.15
                      : context.screenWidth * 0.175,
                ),
                child: Container(
                  height: context.isSmallScreen ? 22.5 : 30,
                  width: context.isSmallScreen ? 22.5 : 30,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: GPColors.transparent,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(Insets.l),
                    color: GPColors.primaryColor,
                  ),
                  child: SizedBox(
                    height: context.isSmallScreen ? 22.5 : 30,
                    width: context.isSmallScreen ? 22.5 : 30,
                    child: Icon(
                      Icons.edit_rounded,
                      color: GPColors.white,
                      size: context.isSmallScreen ? 10 : 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: kDefaultPadding * 2),
          ButtonCommonStyle(
            onPressed: () {
              Provider.of<MixPanelProvider>(context, listen: false).logEvent(
                eventName: EditProfileEvents.editNameScreen.value,
              );
              context.push(
                const EditNameScreen(),
              );
            },
            child: Container(
              height: 50,
              width: 400,
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: GPColors.secondaryColor,
                    width: 0.5,
                  ),
                  bottom: BorderSide(
                    color: GPColors.secondaryColor,
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
                      child: GPTextBody(
                        text: appLocalizations.name,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(width: Insets.l * 2),
                  SizedBox(
                    width: context.isSmallScreen
                        ? context.screenWidth * 0.4
                        : context.screenWidth * 0.5,
                    child: GPTextBody(
                      text: Characters(user?.name ?? appLocalizations.name)
                          .replaceAll(Characters(''), Characters('\u{200B}'))
                          .toString(),
                      overflow: TextOverflow.ellipsis,
                      fontSize: 18,
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
}
