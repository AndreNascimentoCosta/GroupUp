import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/home_view.dart';
import 'package:groupup/styles/button.dart';
import 'package:groupup/screens/groups/screens/groups_screen.dart';
import 'package:groupup/styles/text.dart';

class AppBarGroupSettings extends StatelessWidget with PreferredSizeWidget {
  const AppBarGroupSettings({
    required this.homeViewModel,
  });

  final HomeViewModel homeViewModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.centerStart,
            children: [
              Container(
                width: 390,
                height: 50,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 0.2,
                      color: Color(0xffa1a1a1),
                    ),
                  ),
                ),
                alignment: AlignmentDirectional.center,
                child: const StandardTextStyle(
                  text: 'Group settings',
                  fontFamily: 'Montserrat-Bold',
                  fontSize: TextSize.subTitle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: kDefaultPadding),
                child: ButtonCommonStyle(
                  child: const ImageIcon(
                    AssetImage(
                      'assets/icons/arrow_left.png',
                    ),
                    size: kDefaultPadding * 1.25,
                    color: Colors.black,
                  ),
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
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
