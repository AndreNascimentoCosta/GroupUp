import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/bottom_sheet/gp_modal_bottom_sheet.dart';
import 'package:groupup/core/extensions/gp_navigator_extension.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/providers/storage_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/utils/icons/gp_icons.dart';
import 'package:groupup/core/widgets/buttons/add_picture_button.dart';
import 'package:groupup/core/widgets/buttons/button_common_style.dart';
import 'package:groupup/core/widgets/icons/gp_icon.dart';
import 'package:groupup/core/widgets/loading/gp_loading.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';
import 'package:groupup/core/constants/design_system.dart';
import 'package:groupup/core/providers/create_group_provider.dart';
import 'package:groupup/modules/create_group_page_view/components/create_group_events.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreateGroupAddPicture extends StatefulWidget {
  const CreateGroupAddPicture({super.key});

  @override
  State<CreateGroupAddPicture> createState() => _CreateGroupAddPictureState();
}

class _CreateGroupAddPictureState extends State<CreateGroupAddPicture> {
  File? image;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return ButtonCommonStyle(
      onPressed: () {
        Provider.of<MixPanelProvider>(context, listen: false).logEvent(
          eventName: CreateGroupEvents.pressAddGroupPicture.value,
        );
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
                      eventName: CreateGroupEvents
                          .pressChooseFromGalleryAddPicture.value,
                    );
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
                        .logEvent(
                      eventName:
                          CreateGroupEvents.pressTakePhotoAddPicture.value,
                    );
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
              AddPicture(
                onPressedGallery: () {
                  Provider.of<MixPanelProvider>(context, listen: false)
                      .logEvent(
                    eventName: CreateGroupEvents
                        .pressChooseFromGalleryAddPicture.value,
                  );
                  pickImage(ImageSource.gallery);
                },
                onPressedCamera: () {
                  Provider.of<MixPanelProvider>(context, listen: false)
                      .logEvent(
                    eventName: CreateGroupEvents.pressTakePhotoAddPicture.value,
                  );
                  pickImage(ImageSource.camera);
                },
                child: Builder(
                  builder: (context) {
                    final storage = Provider.of<StorageProvider>(context);
                    final avatarCommonSize = context.isVerySmallScreen
                        ? Insets.l * 8
                        : context.isSmallScreen
                            ? Insets.l * 7
                            : Insets.l * 6;
                    if (image != null) {
                      return Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                              avatarCommonSize,
                            ),
                            child: Image.file(
                              image!,
                              height: avatarCommonSize,
                              width: avatarCommonSize,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Visibility(
                            visible: storage.isLoading,
                            child: Container(
                              height: avatarCommonSize,
                              width: avatarCommonSize,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    avatarCommonSize,
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

  Future pickImage(ImageSource source) async {
    context.pop();
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
}
