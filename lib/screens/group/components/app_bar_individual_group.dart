import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/models/group.dart';
import 'package:groupup/models/home_view.dart';
import 'package:groupup/screens/group_settings/screens/group_settings_screen.dart';
import 'package:groupup/screens/groups/screens/groups_screen.dart';

class AppBarIndividualGroup extends StatelessWidget with PreferredSizeWidget {
  const AppBarIndividualGroup(
      {required this.homeViewModel,
      required this.groupModel,});

  final HomeViewModel homeViewModel;
  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: AlignmentDirectional.center,
            image: AssetImage(
              groupModel.image,
            ),
            fit: BoxFit.cover,
            opacity: 0.9,
          ),
        ),
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
            child: const ImageIcon(
              AssetImage(
                'assets/icons/arrow_left.png',
              ),
              size: kDefaultPadding * 1.25,
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
                          builder: (context) => GroupSettings(homeViewModel: homeViewModel,),
                        ),
                      );
                    },
                    child: const ImageIcon(
                      AssetImage(
                        'assets/icons/settings.png',
                      ),
                      size: kDefaultPadding * 1.25,
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
