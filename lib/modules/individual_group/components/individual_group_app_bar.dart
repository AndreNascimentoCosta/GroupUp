import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/core/extensions/gp_navigator_extension.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/providers/storage_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/constants/design_system.dart';
import 'package:groupup/core/utils/icons/gp_icons.dart';
import 'package:groupup/core/utils/images/gp_images.dart';
import 'package:groupup/core/widgets/icons/gp_icon.dart';
import 'package:groupup/models/home_view_model.dart';
import 'package:groupup/modules/individual_group/components/edit_group_picture_button.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/modules/individual_group/components/individual_group_events.dart';
import 'package:groupup/modules/individual_group_settings/screens/individual_group_settings_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class IndividualGroupAppBar extends StatefulWidget
    implements PreferredSizeWidget {
  const IndividualGroupAppBar({
    required this.homeViewModel,
  });

  final HomeViewModel homeViewModel;

  @override
  State<IndividualGroupAppBar> createState() => _IndividualGroupAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

class _IndividualGroupAppBarState extends State<IndividualGroupAppBar> {
  @override
  Widget build(BuildContext context) {
    final group = Provider.of<IndividualGroupProvider>(context).group;
    final individualGroupProvider =
        Provider.of<IndividualGroupProvider>(context);
    final currentUserId = Provider.of<AuthProvider>(context).user?.id;
    if (group == null) {
      return AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        flexibleSpace: ClipRect(
          child: SvgPicture.asset(
            GPImages.groupupPlaceholder,
            fit: BoxFit.cover,
          ),
        ),
        title: Row(
          children: [
            FloatingActionButton(
              heroTag: 'btn1',
              elevation: 0,
              backgroundColor: GPColors.white,
              onPressed: () {
                Provider.of<MixPanelProvider>(context, listen: false).logEvent(
                  eventName:
                      IndividualGroupEvents.presBackButtonIndividualGroup.value,
                );
                Navigator.pop(context);
              },
              child: const GPIcon(
                GPIcons.arrowLeft,
                color: GPColors.black,
                height: Insets.l * 1.25,
                width: Insets.l * 1.25,
              ),
            ),
            const Spacer(),
            FloatingActionButton(
              heroTag: 'btn2',
              elevation: 0,
              backgroundColor: GPColors.white,
              onPressed: () {},
              child: const GPIcon(
                GPIcons.settings,
                color: GPColors.black,
                height: Insets.l * 1.25,
                width: Insets.l * 1.25,
              ),
            )
          ],
        ),
      );
    }
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      flexibleSpace: group.image != ''
          ? ClipRect(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      group.image,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          : ClipRect(
              child: SvgPicture.asset(
                GPImages.groupupPlaceholder,
                fit: BoxFit.cover,
              ),
            ),
      title: ValueListenableBuilder(
        valueListenable: widget.homeViewModel.isEditing,
        builder: ((context, value, child) {
          final currentUserData =
              individualGroupProvider.group!.participantsData.firstWhere(
            (element) => element.uid == currentUserId,
          );
          return Row(
            children: [
              Visibility(
                visible: !value,
                child: FloatingActionButton(
                  heroTag: 'btn1',
                  elevation: 0,
                  backgroundColor: GPColors.white,
                  onPressed: individualGroupProvider.pageIndex == 0
                      ? () {
                          Provider.of<MixPanelProvider>(context, listen: false)
                              .logEvent(
                            eventName: IndividualGroupEvents
                                .presBackButtonIndividualGroup.value,
                          );
                          Navigator.pop(context);
                        }
                      : () {
                          Provider.of<MixPanelProvider>(context, listen: false)
                              .logEvent(
                            eventName: IndividualGroupEvents
                                .pageZeroPageViewIndividualGroup.value,
                          );
                          individualGroupProvider.pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                        },
                  child: const GPIcon(
                    GPIcons.arrowLeft,
                    color: GPColors.black,
                    height: Insets.l * 1.25,
                    width: Insets.l * 1.25,
                  ),
                ),
              ),
              const Spacer(),
              Builder(
                builder: (context) {
                  final editGroupPictureButton = EditGroupPictureButton(
                    onPressedGallery: () {
                      Provider.of<MixPanelProvider>(context, listen: false)
                          .logEvent(
                        eventName: IndividualGroupEvents
                            .pressChoosePhotoToChangeGroupPicture.value,
                      );
                      pickImage(ImageSource.gallery);
                    },
                    onPressedCamera: () {
                      Provider.of<MixPanelProvider>(context, listen: false)
                          .logEvent(
                        eventName: IndividualGroupEvents
                            .pressTakePhotoToChangeGroupPicture.value,
                      );
                      pickImage(ImageSource.camera);
                    },
                    child: const FloatingActionButton(
                      heroTag: 'btn2',
                      elevation: 0,
                      backgroundColor: GPColors.white,
                      onPressed: null,
                      child: GPIcon(
                        GPIcons.edit,
                        color: GPColors.black,
                        height: Insets.l * 1.25,
                        width: Insets.l * 1.25,
                      ),
                    ),
                  );
                  final individualGroupSettingsButton = FloatingActionButton(
                    heroTag: 'btn2',
                    elevation: 0,
                    backgroundColor: GPColors.white,
                    onPressed: () {
                      Provider.of<MixPanelProvider>(context, listen: false)
                          .logEvent(
                        eventName: IndividualGroupEvents
                            .pressIndividualGroupSettingsButton.value,
                      );
                      context.push(
                        IndividualGroupSettingsScreen(
                          homeViewModel: widget.homeViewModel,
                          groups: group,
                        ),
                      );
                    },
                    child: const GPIcon(
                      GPIcons.settings,
                      color: GPColors.black,
                      height: Insets.l * 1.25,
                      width: Insets.l * 1.25,
                    ),
                  );
                  if (!group.allowEditImage) {
                    if (currentUserData.isAdmin) {
                      if (!value) {
                        return individualGroupSettingsButton;
                      } else {
                        return editGroupPictureButton;
                      }
                    } else {
                      return individualGroupSettingsButton;
                    }
                  } else {
                    if (!value) {
                      return individualGroupSettingsButton;
                    } else {
                      return editGroupPictureButton;
                    }
                  }
                },
              ),
            ],
          );
        }),
      ),
    );
  }

  Future pickImage(ImageSource source) async {
    Navigator.pop(context);
    final group =
        Provider.of<IndividualGroupProvider>(context, listen: false).group;
    final individualGroupProvider =
        Provider.of<IndividualGroupProvider>(context, listen: false);
    final storage = Provider.of<StorageProvider>(context, listen: false);
    try {
      final image = await ImagePicker().pickImage(
        source: source,
        imageQuality: 60,
      );
      if (image == null) return;
      if (group == null) return;

      storage.image = File(image.path);
      if (!mounted) return;
      await storage.uploadGroupImage(context, group.id);
      individualGroupProvider.getGroup(group.id, reset: false);
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }
}
