import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/providers/storage_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/utils/icons/gp_icons.dart';
import 'package:groupup/core/widgets/icons/gp_icon.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/core/constants/design-system.dart';
import 'package:groupup/models/group_model.dart';
import 'package:groupup/screens/created_groups/screens/created_groups_screen.dart';
import 'package:groupup/screens/edit_profile/screens/edit_profile.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/screens/profile/components/profile_picture_add.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/screens/profile/components/app_bar.dart';
import 'package:groupup/screens/profile/components/body_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'edit_profile_button.dart';

class BodyProfile extends StatefulWidget {
  const BodyProfile({super.key});

  @override
  State<BodyProfile> createState() => _BodyProfileState();
}

class _BodyProfileState extends State<BodyProfile> {
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
    final appLocalizations = AppLocalizations.of(context)!;
    final screenHeight = context.screenHeight;
    final screenWidth = context.screenWidth;
    final isSmallScreen = screenHeight < 800 || screenWidth < 350;
    if (user == null) return const SizedBox();
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .where('id', isEqualTo: user.id)
          .snapshots(),
      builder: (context, snapshot) {
        // final data = snapshot.data?.docs.first.data()['balance'];
        if (snapshot.hasData == false || snapshot.data == null) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else {
          return Scaffold(
            backgroundColor: GPColors.white,
            appBar: const AppBarProfile(),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: kDefaultPadding),
                  ProfilePictureShow(
                    onPressedGallery: () {},
                    onPressedCamera: () {},
                    child: Builder(
                      builder: (context) {
                        final storage = Provider.of<StorageProvider>(context);
                        final userProfilePicture = user.profilePicture;

                        final profilePicture = storage.profilePicture;

                        if (profilePicture != null) {
                          return Stack(
                            children: [
                              ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(Insets.l * 6),
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
                                  child: const Center(
                                    child: CircularProgressIndicator.adaptive(),
                                  ),
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
                          height: isSmallScreen ? Insets.l * 2 : Insets.l * 3,
                          width: isSmallScreen ? Insets.l * 2 : Insets.l * 3,
                        );
                      },
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
                        child: StaticText(
                          text: Characters(user.name)
                              .replaceAll(
                                  Characters(''), Characters('\u{200B}'))
                              .toString(),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          fontSize: TextSize.subTitle,
                          fontFamily: 'Montserrat-SemiBold',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: kDefaultPadding * 1.25),
                  ButtonCommonStyle(
                    onPressed: () {
                      Provider.of<MixPanelProvider>(context, listen: false)
                          .logEvent(eventName: 'Edit Profile Screen');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EditProfileScreen(),
                          settings: const RouteSettings(name: 'Edit_Profile'),
                        ),
                      );
                    },
                    child: const EditProfile(),
                  ),
                  // const SizedBox(height: kDefaultPadding * 2.5),
                  // BodyButtonModel(
                  //   onPressed: () {
                  //     Provider.of<MixPanelProvider>(context, listen: false)
                  //         .logEvent(eventName: 'Balance Screen');
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => BalanceScreen(
                  //           groupsData: groupsData,
                  //         ),
                  //         settings: const RouteSettings(name: 'Balance'),
                  //       ),
                  //     );
                  //   },
                  //   text: appLocalizations.balance,
                  //   secondaryText: 'R\$ ${NumberFormat.decimalPattern(
                  //     Localizations.localeOf(context).toString(),
                  //   ).format(
                  //     double.parse('${(data / 100)}'),
                  //   )}',
                  // ),
                  const SizedBox(height: kDefaultPadding * 2),
                  BodyButtonModel(
                    onPressed: () {
                      Provider.of<MixPanelProvider>(context, listen: false)
                          .logEvent(eventName: 'Created Groups Screen');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CreatedGroupsScreen(),
                          settings: const RouteSettings(name: 'Created_Groups'),
                        ),
                      );
                    },
                    text: appLocalizations.createdGroups,
                    secondaryText: '',
                  ),
                  // const SizedBox(height: kDefaultPadding * 2),
                  // BodyButtonModel(
                  //   onPressed: () {
                  //     Provider.of<MixPanelProvider>(context, listen: false)
                  //         .logEvent(eventName: 'Saved Cards Screen');
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => const SavedCardsScreen(),
                  //         settings: const RouteSettings(name: 'Saved_Cards'),
                  //       ),
                  //     );
                  //   },
                  //   text: appLocalizations.savedCards,
                  //   secondaryText: '',
                  // )
                ],
              ),
            ),
          );
        }
      },
    );
  }

  final List<GroupModel> groupsData = [];
}
