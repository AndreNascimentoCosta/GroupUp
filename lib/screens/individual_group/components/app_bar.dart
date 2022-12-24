import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/group.dart';
import 'package:groupup/models/home_view.dart';
import 'package:groupup/screens/individual_group_settings/screens/group_settings.dart';
import 'package:groupup/screens/groups/screens/groups_screen.dart';
import 'package:photo_view/photo_view.dart';

class AppBarIndividualGroup extends StatelessWidget with PreferredSizeWidget {
  const AppBarIndividualGroup({
    required this.homeViewModel,
    required this.groupModel,
  });

  final HomeViewModel homeViewModel;
  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      flexibleSpace: ValueListenableBuilder(
        valueListenable: homeViewModel.isEditing,
        builder: ((context, value, child) {
          return ClipRect(
            child: PhotoView(
              filterQuality: FilterQuality.high,
              imageProvider: AssetImage(groupModel.image),
              minScale: PhotoViewComputedScale.covered,
              maxScale: PhotoViewComputedScale.covered * 2,
              disableGestures: value ? false : true,
              loadingBuilder: (context, event) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          );
        }),
      ),
      title: Row(
        children: [
          FloatingActionButton(
            heroTag: 'btn1',
            backgroundColor: Colors.white,
            onPressed: () {
              Navigator.pop(
                context,
                MaterialPageRoute(
                  builder: (context) => GroupsScreen(
                    homeViewModel: homeViewModel,
                  ),
                ),
              );
            },
            child: SvgPicture.asset(
              'assets/icons/arrow_left.svg',
              height: Insets.l * 1.25,
              width: Insets.l * 1.25,
              color: Colors.black,
            ),
          ),
          const Spacer(),
          ValueListenableBuilder(
              valueListenable: homeViewModel.isEditing,
              builder: (context, value, child) {
                return Visibility(
                  visible: !value,
                  child: FloatingActionButton(
                    heroTag: 'btn2',
                    backgroundColor: Colors.white,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GroupSettings(
                            homeViewModel: homeViewModel,
                            groupModel: groupModel,
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
                  ),
                );
              })
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
