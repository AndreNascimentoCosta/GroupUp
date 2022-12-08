import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/models/dropdown.dart';
import 'package:groupup/models/group.dart';
import 'package:groupup/models/home_view.dart';
import 'package:groupup/screens/group_settings/group_settings_screen.dart';
import 'package:groupup/screens/groups/groups_screen.dart';

class AppBarIndividualGroup extends StatelessWidget with PreferredSizeWidget {
  const AppBarIndividualGroup(
      {required this.homeViewModel,
      required this.groupModel,
      required this.dropDownModel});

  final HomeViewModel homeViewModel;
  final GroupModel groupModel;
  final DropDownModel dropDownModel;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            alignment: AlignmentDirectional.topCenter,
            image: AssetImage(
              'assets/images/runforest_hq.png',
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
                    dropDownModel: dropDownModel,
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
                          builder: (context) => const GroupSettings(),
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
