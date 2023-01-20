import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/providers/storage.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/home_view.dart';
import 'package:groupup/screens/individual_group/components/group_picture_edit.dart';
import 'package:groupup/screens/individual_group/components/individual_group_provider.dart';
import 'package:groupup/screens/individual_group_settings/screens/group_settings.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AppBarIndividualGroup extends StatefulWidget with PreferredSizeWidget {
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
      // ignore: avoid_print
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final group = Provider.of<IndividualGroupProvider>(context).group;
    if (group == null) {
      return const CircularProgressIndicator(color: kPrimaryColor);
    }
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      flexibleSpace: group.image != ''
          ? ClipRect(
              child: Image.network(
                group.image,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  final storage = Provider.of<StorageProvider>(context);
                  final File? image = storage.image;
                  if (loadingProgress == null) return child;
                  if (image != null) {
                    return Image.file(
                      image,
                      fit: BoxFit.cover,
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(
                      color: kPrimaryColor,
                    ),
                  );
                },
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
          return Row(
            children: [
              Visibility(
                visible: !value,
                child: FloatingActionButton(
                  heroTag: 'btn1',
                  elevation: 0,
                  backgroundColor: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset(
                    'assets/icons/arrow_left.svg',
                    height: Insets.l * 1.25,
                    width: Insets.l * 1.25,
                    color: Colors.black,
                  ),
                ),
              ),
              const Spacer(),
              !value
                  ? FloatingActionButton(
                      heroTag: 'btn2',
                      elevation: 0,
                      backgroundColor: Colors.white,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GroupSettings(
                              homeViewModel: widget.homeViewModel,
                              groups: group,
                            ),
                          ),
                        );
                      },
                      child: SvgPicture.asset(
                        'assets/icons/settings.svg',
                        height: Insets.l * 1.25,
                        width: Insets.l * 1.25,
                        color: Colors.black,
                      ),
                    )
                  : GroupPictureEdit(
                      onPressedGallery: () {
                        pickImage(ImageSource.gallery);
                      },
                      onPressedCamera: () {
                        pickImage(ImageSource.camera);
                      },
                      child: FloatingActionButton(
                        heroTag: 'btn2',
                        elevation: 0,
                        backgroundColor: Colors.white,
                        onPressed: null,
                        child: SvgPicture.asset(
                          'assets/icons/edit.svg',
                          height: Insets.l * 1.25,
                          width: Insets.l * 1.25,
                          color: Colors.black,
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
