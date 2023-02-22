import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/providers/storage_provider.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/group_model.dart';
import 'package:groupup/screens/balance/screens/balance.dart';
import 'package:groupup/screens/created_groups/screens/created_groups_screen.dart';
import 'package:groupup/screens/edit_profile/screens/edit_profile.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/screens/profile/components/profile_picture_add.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/screens/profile/components/app_bar.dart';
import 'package:groupup/screens/profile/components/body_button.dart';
import 'package:groupup/screens/saved_cards/screens/saved_cards_join_group_screen.dart';
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
      // ignore: avoid_print
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;
    final appLocalizations = AppLocalizations.of(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenHeight < 800 || screenWidth < 350;
    if (user == null) return const SizedBox();
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .where('id', isEqualTo: user.id)
          .snapshots(),
      builder: (context, snapshot) {
        final data = snapshot.data?.docs.first.data()['balance'];
        if (snapshot.hasData == false || snapshot.data == null) {
          return const Center(
            child: CircularProgressIndicator(color: kPrimaryColor),
          );
        } else {
          return Scaffold(
            backgroundColor: Colors.white,
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
                        if (userProfilePicture.isNotEmpty == true) {
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
                          height:  isSmallScreen ? Insets.l * 2 : Insets.l * 3,
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EditProfileScreen(),
                        ),
                      );
                    },
                    child: const EditProfile(),
                  ),
                  const SizedBox(height: kDefaultPadding * 2.5),
                  BodyButtonModel(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BalanceScreen(
                            groupsData: groupsData,
                          ),
                        ),
                      );
                    },
                    text: appLocalizations.balance,
                    secondaryText:
                        'R\$ ${Characters((data / 100).toStringAsFixed(2)).replaceAll(Characters(''), Characters('\u{200B}')).toString()}',
                  ),
                  const SizedBox(height: kDefaultPadding * 2),
                  BodyButtonModel(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CreatedGroupsScreen(),
                        ),
                      );
                    },
                    text: appLocalizations.createdGroups,
                    secondaryText: '',
                  ),
                  const SizedBox(height: kDefaultPadding * 2),
                  BodyButtonModel(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SavedCardsScreen(),
                        ),
                      );
                    },
                    text: 'Saved cards',
                    secondaryText: '',
                  )
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
