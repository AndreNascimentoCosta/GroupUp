import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/core/providers/storage_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/constants/design-system.dart';
import 'package:groupup/core/utils/icons/gp_icons.dart';
import 'package:groupup/core/utils/images/gp_images.dart';
import 'package:groupup/core/widgets/icons/gp_icon.dart';
import 'package:groupup/models/home_view.dart';
import 'package:groupup/modules/individual_group/components/group_picture_edit.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/modules/individual_group_settings/screens/group_settings.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../core/providers/auth_provider.dart';
import '../../../core/providers/mix_panel_provider.dart';

class AppBarIndividualGroup extends StatefulWidget
    implements PreferredSizeWidget {
  const AppBarIndividualGroup({
    required this.homeViewModel,
  });

  final HomeViewModel homeViewModel;

  @override
  State<AppBarIndividualGroup> createState() => _AppBarIndividualGroupState();

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

class _AppBarIndividualGroupState extends State<AppBarIndividualGroup> {
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
                    eventName: 'Leave Individual Group Screen - Back Button');
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
                'assets/images/groupup_placeholder.svg',
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
                                  eventName:
                                      'Leave Individual Group Screen - Back Button');
                          Navigator.pop(context);
                        }
                      : () {
                          Provider.of<MixPanelProvider>(context, listen: false)
                              .logEvent(
                                  eventName:
                                      'Back one page Individual Group Settings Screen - Back Button');
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
              !group.allowEditImage
                  ? currentUserData.isAdmin
                      ? !value
                          ? FloatingActionButton(
                              heroTag: 'btn2',
                              elevation: 0,
                              backgroundColor: GPColors.white,
                              onPressed: () {
                                Provider.of<MixPanelProvider>(context,
                                        listen: false)
                                    .logEvent(
                                        eventName:
                                            'Individual Group Settings Screen');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => GroupSettings(
                                      homeViewModel: widget.homeViewModel,
                                      groups: group,
                                    ),
                                    settings: const RouteSettings(
                                      name: 'Group_Settings',
                                    ),
                                  ),
                                );
                              },
                              child: const GPIcon(
                                GPIcons.settings,
                                color: GPColors.black,
                                height: Insets.l * 1.25,
                                width: Insets.l * 1.25,
                              ),
                            )
                          : GroupPictureEdit(
                              onPressedGallery: () {
                                Provider.of<MixPanelProvider>(context,
                                        listen: false)
                                    .logEvent(
                                        eventName:
                                            'Choose Photo to Change Group Image');
                                pickImage(ImageSource.gallery);
                              },
                              onPressedCamera: () {
                                Provider.of<MixPanelProvider>(context,
                                        listen: false)
                                    .logEvent(
                                        eventName:
                                            'Take Photo to Change Group Image');
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
                            )
                      : FloatingActionButton(
                          heroTag: 'btn2',
                          elevation: 0,
                          backgroundColor: GPColors.white,
                          onPressed: () {
                            Provider.of<MixPanelProvider>(context,
                                    listen: false)
                                .logEvent(
                                    eventName:
                                        'Individual Group Settings Screen');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GroupSettings(
                                  homeViewModel: widget.homeViewModel,
                                  groups: group,
                                ),
                                settings: const RouteSettings(
                                  name: 'Group_Settings',
                                ),
                              ),
                            );
                          },
                          child: const GPIcon(
                            GPIcons.settings,
                            color: GPColors.black,
                            height: Insets.l * 1.25,
                            width: Insets.l * 1.25,
                          ),
                        )
                  : !value
                      ? FloatingActionButton(
                          heroTag: 'btn2',
                          elevation: 0,
                          backgroundColor: GPColors.white,
                          onPressed: () {
                            Provider.of<MixPanelProvider>(context,
                                    listen: false)
                                .logEvent(
                                    eventName:
                                        'Individual Group Settings Screen');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GroupSettings(
                                  homeViewModel: widget.homeViewModel,
                                  groups: group,
                                ),
                                settings: const RouteSettings(
                                  name: 'Group_Settings',
                                ),
                              ),
                            );
                          },
                          child: const GPIcon(
                            GPIcons.settings,
                            color: GPColors.black,
                            height: Insets.l * 1.25,
                            width: Insets.l * 1.25,
                          ),
                        )
                      : GroupPictureEdit(
                          onPressedGallery: () {
                            Provider.of<MixPanelProvider>(context,
                                    listen: false)
                                .logEvent(
                                    eventName:
                                        'Choose Photo to Change Group Image');
                            pickImage(ImageSource.gallery);
                          },
                          onPressedCamera: () {
                            Provider.of<MixPanelProvider>(context,
                                    listen: false)
                                .logEvent(
                                    eventName:
                                        'Take Photo to Change Group Image');
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
                        ),
            ],
          );
        }),
      ),
    );
  }
}
