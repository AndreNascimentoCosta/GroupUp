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
import 'package:groupup/core/widgets/icons/gp_icon.dart';
import 'package:groupup/core/constants/design_system.dart';
import 'package:groupup/core/widgets/loading/gp_loading.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';
import 'package:groupup/core/widgets/texts/gp_text_header.dart';
import 'package:groupup/modules/created_groups/screens/created_groups_screen.dart';
import 'package:groupup/modules/edit_profile/screens/edit_profile.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/modules/profile/components/edit_profile_button.dart';
import 'package:groupup/modules/profile/components/profile_events.dart';
import 'package:groupup/core/widgets/buttons/button_common_style.dart';
import 'package:groupup/modules/profile/components/profile_app_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BodyProfile extends StatefulWidget {
  const BodyProfile({super.key});

  @override
  State<BodyProfile> createState() => _BodyProfileState();
}

class _BodyProfileState extends State<BodyProfile> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;
    final appLocalizations = AppLocalizations.of(context)!;
    if (user == null) return const SizedBox();
    return Scaffold(
      backgroundColor: GPColors.white,
      appBar: const ProfileAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: kDefaultPadding),
            ButtonCommonStyle(
              child: Align(
                alignment: AlignmentDirectional.topCenter,
                child: CircleAvatar(
                  radius: context.screenHeight * 0.06,
                  backgroundColor: const Color(0XFFE1E1E1),
                  child: Builder(
                    builder: (context) {
                      final storage = Provider.of<StorageProvider>(context);
                      final profilePicture = storage.profilePicture;
                      final userProfilePicture = user.profilePicture;
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
                      if (userProfilePicture.isNotEmpty == true) {
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
              ),
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 250,
                  child: GPTextHeader(
                    text: Characters(user.name)
                        .replaceAll(Characters(''), Characters('\u{200B}'))
                        .toString(),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: kDefaultPadding * 1.25,
            ),
            ButtonCommonStyle(
              onPressed: () {
                Provider.of<MixPanelProvider>(context, listen: false).logEvent(
                  eventName: ProfileEvents.pressEditProfileButton.value,
                );
                context.push(
                  const EditProfileScreen(),
                );
              },
              child: const EditProfile(),
            ),
            const SizedBox(
              height: kDefaultPadding * 2,
            ),
            ButtonCommonStyle(
              onPressed: () {
                Provider.of<MixPanelProvider>(context, listen: false).logEvent(
                  eventName: ProfileEvents.pressCreatedGroupsButton.value,
                );
                context.push(
                  const CreatedGroupsScreen(),
                );
              },
              child: Row(
                children: [
                  GPTextBody(
                    text: appLocalizations.createdGroups,
                    fontSize: 16,
                  ),
                  const Spacer(),
                  const Padding(
                    padding: EdgeInsets.only(right: kDefaultPadding),
                    child: GPTextBody(
                      text: '',
                      fontSize: 16,
                    ),
                  ),
                  const GPIcon(
                    GPIcons.arrowRight,
                    height: Insets.l,
                    width: Insets.l,
                  ),
                ],
              ),
            ),
          ],
        ),
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
