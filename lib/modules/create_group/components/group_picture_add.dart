import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/bottom_sheet/gp_modal_bottom_sheet.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/providers/storage_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/utils/icons/gp_icons.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/widgets/icons/gp_icon.dart';
import 'package:groupup/core/widgets/loading/gp_loading.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';
import 'package:groupup/core/constants/design-system.dart';
import 'package:groupup/modules/edit_profile/components/profile_picture_add.dart';
import 'package:groupup/core/providers/create_group_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/providers/mix_panel_provider.dart';

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
      debugPrint('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return ButtonCommonStyle(
      onPressed: () {
        Provider.of<MixPanelProvider>(context, listen: false)
            .logEvent(eventName: 'Create Group - Add Picture');
        gpModalBottomSheet(
          context,
          context.screenHeight * 0.185,
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: kDefaultPadding * 1.75,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ButtonCommonStyle(
                  onPressed: () {
                    Provider.of<MixPanelProvider>(context, listen: false)
                        .logEvent(
                            eventName: 'Create Group - Choose From Gallery');
                    pickImage(ImageSource.gallery);
                  },
                  child: GPTextBody(
                    text: appLocalizations.chooseFromGallery,
                    textAlign: TextAlign.center,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: Insets.l * 1.75),
                ButtonCommonStyle(
                  onPressed: () {
                    Provider.of<MixPanelProvider>(context, listen: false)
                        .logEvent(eventName: 'Create Group - Take Photo');
                    pickImage(ImageSource.camera);
                  },
                  child: GPTextBody(
                    text: appLocalizations.takePhoto,
                    textAlign: TextAlign.center,
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
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
                  Provider.of<MixPanelProvider>(context, listen: false)
                      .logEvent(
                          eventName: 'Create Group - Choose From Gallery');
                  pickImage(ImageSource.gallery);
                },
                onPressedCamera: () {
                  Provider.of<MixPanelProvider>(context, listen: false)
                      .logEvent(eventName: 'Create Group - Take Photo');
                  pickImage(ImageSource.camera);
                },
                child: Builder(
                  builder: (context) {
                    final storage = Provider.of<StorageProvider>(context);

                    if (image != null) {
                      return Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                              context.isVerySmallScreen
                                  ? Insets.l * 8
                                  : context.isSmallScreen
                                      ? Insets.l * 7
                                      : Insets.l * 6,
                            ),
                            child: Image.file(
                              image!,
                              height: context.isVerySmallScreen
                                  ? Insets.l * 8
                                  : context.isSmallScreen
                                      ? Insets.l * 7
                                      : Insets.l * 6,
                              width: context.isVerySmallScreen
                                  ? Insets.l * 8
                                  : context.isSmallScreen
                                      ? Insets.l * 7
                                      : Insets.l * 6,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Visibility(
                            visible: storage.isLoading,
                            child: Container(
                              height: context.isVerySmallScreen
                                  ? Insets.l * 8
                                  : context.isSmallScreen
                                      ? Insets.l * 7
                                      : Insets.l * 6,
                              width: context.isVerySmallScreen
                                  ? Insets.l * 8
                                  : context.isSmallScreen
                                      ? Insets.l * 7
                                      : Insets.l * 6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    context.isVerySmallScreen
                                        ? Insets.l * 8
                                        : context.isSmallScreen
                                            ? Insets.l * 7
                                            : Insets.l * 6,
                                  ),
                                ),
                                color: GPColors.black,
                              ),
                              child: const GPLoading(),
                            ),
                          ),
                        ],
                      );
                    }
                    return GPIcon(
                      GPIcons.profilePictureAdd,
                      color: GPColors.white,
                      height: context.isVerySmallScreen
                          ? Insets.l * 1.5
                          : context.isSmallScreen
                              ? Insets.l * 2
                              : Insets.l * 2.5,
                      width: context.isVerySmallScreen
                          ? Insets.l * 1.5
                          : context.isSmallScreen
                              ? Insets.l * 1.75
                              : Insets.l * 2.5,
                    );
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              top: context.screenHeight * 0.081,
              left: context.screenHeight * 0.081,
            ),
            child: Container(
              height: context.screenHeight * 0.04,
              width: context.screenHeight * 0.04,
              decoration: BoxDecoration(
                border: Border.all(
                  color: GPColors.transparent,
                  width: 4,
                ),
                borderRadius: BorderRadius.circular(Insets.xl),
                color: GPColors.primaryColor,
              ),
              child: Icon(
                Icons.add_rounded,
                color: GPColors.white,
                size: context.isVerySmallScreen
                    ? context.screenHeight * 0.025
                    : context.isSmallScreen
                        ? context.screenHeight * 0.027
                        : context.screenHeight * 0.031,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
