import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/group.dart';
import 'package:groupup/styles/button.dart';
import 'package:groupup/styles/text.dart';
import '../../../models/home_view.dart';

class AppBarGroup extends StatefulWidget with PreferredSizeWidget {
  AppBarGroup({required this.homeViewModel});

  final HomeViewModel homeViewModel;

  @override
  State<AppBarGroup> createState() => _AppBarGroupState();

  @override
  Size get preferredSize => const Size.fromHeight(55);
}

class _AppBarGroupState extends State<AppBarGroup> {
  HashSet selectItems = HashSet();

  @override
  Widget build(BuildContext context) {
    return buildAppBar();
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      title: const StandardTextStyle(
        text: 'Groups',
        fontFamily: 'Montserrat-Bold',
        fontSize: TextSize.title,
      ),
      centerTitle: false,
      actions: [
        Padding(
          padding: const EdgeInsets.only(
              bottom: kDefaultPadding / 2, right: kDefaultPadding / 1.25),
          child: Align(
            widthFactor: 1.5,
            alignment: Alignment.bottomRight,
            child: Row(
              children: [
                ValueListenableBuilder(
                    valueListenable: widget.homeViewModel.isEditing,
                    builder: (context, value, child) {
                      return Visibility(
                        visible: value,
                        child: ButtonCommonStyle(
                          onPressed: () {
                            setState(() {
                              if(selectItems.length == groupsData.length) {
                              selectItems.clear();
                            } else {
                              for(int index = 0; index < groupsData.length; index++) {
                                selectItems.add(groupsData[index]);
                              }
                            }
                            });
                          },
                          padding: const EdgeInsets.only(bottom: kDefaultPadding / 2, right: kDefaultPadding * 4),
                          child: const StandardTextStyle(
                            text: 'Select all',
                            fontSize: TextSize.lBody,
                          ),
                        ),
                      );
                    }),
                const SizedBox(width: Insets.l),
                ButtonCommonStyle(
                  onPressed: () {
                    widget.homeViewModel.switchEdit();
                  },
                  padding: const EdgeInsets.only(bottom: kDefaultPadding / 2, right: kDefaultPadding * 4),
                  child: const StandardTextStyle(
                    text: 'Edit',
                    fontSize: TextSize.lBody,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
