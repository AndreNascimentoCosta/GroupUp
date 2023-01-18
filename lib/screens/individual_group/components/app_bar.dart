import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/providers/storage.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/group_model.dart';
import 'package:groupup/models/home_view.dart';
import 'package:groupup/screens/edit_profile/components/profile_picture_add.dart';
import 'package:groupup/screens/individual_group/components/group_picture_edit.dart';
import 'package:groupup/screens/individual_group_settings/screens/group_settings.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../home/components/bottom_sheet/create/create_group_provider.dart';

class AppBarIndividualGroup extends StatefulWidget with PreferredSizeWidget {
  const AppBarIndividualGroup({
    required this.homeViewModel,
    required this.groups,
  });

  final HomeViewModel homeViewModel;
  final GroupModel groups;

  @override
  State<AppBarIndividualGroup> createState() => _AppBarIndividualGroupState();

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

class _AppBarIndividualGroupState extends State<AppBarIndividualGroup> {
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
      // ignore: avoid_print
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      flexibleSpace: widget.groups.image != ''
          ? ClipRect(
              child: Image.network(
                widget.groups.image,
                fit: BoxFit.cover,
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
                              groups: widget.groups,
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
                        backgroundColor: kPrimaryColor,
                        onPressed: null,
                        child: SvgPicture.asset(
                          'assets/icons/plus.svg',
                          height: Insets.l * 1.25,
                          width: Insets.l * 1.25,
                          color: Colors.white,
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
