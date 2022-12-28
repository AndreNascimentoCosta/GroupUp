import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/models/group.dart';
import '../../../models/home_view.dart';

class AppBarGroup extends StatefulWidget with PreferredSizeWidget {
  AppBarGroup({required this.homeViewModel, required this.groupsData});

  final HomeViewModel homeViewModel;
  final List<GroupModel> groupsData;

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
      title: const StaticText(
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
                              if (selectItems.length ==
                                  widget.groupsData.length) {
                                selectItems.clear();
                              } else {
                                for (int index = 0;
                                    index < widget.groupsData.length;
                                    index++) {
                                  selectItems.add(widget.groupsData[index]);
                                }
                              }
                            });
                          },
                          padding: const EdgeInsets.only(
                              bottom: kDefaultPadding / 2,
                              right: kDefaultPadding * 4),
                          child: const StaticText(
                            text: 'Select all',
                            fontSize: TextSize.lBody,
                          ),
                        ),
                      );
                    }),
                const SizedBox(width: Insets.l),
                widget.groupsData.isEmpty
                    ? const StaticText(
                        text: 'Edit',
                        fontSize: TextSize.lBody,
                        color: kSecondaryColor,
                      )
                    : ButtonCommonStyle(
                        onPressed: () {
                          widget.homeViewModel.switchEdit();
                        },
                        padding: const EdgeInsets.only(
                            bottom: kDefaultPadding / 2,
                            right: kDefaultPadding * 4),
                        child: ValueListenableBuilder(
                            valueListenable: widget.homeViewModel.isEditing,
                            builder: ((context, value, child) {
                              return !value
                                  ? const StaticText(
                                      text: 'Edit',
                                      fontSize: TextSize.lBody,
                                    )
                                  : const StaticText(
                                      text: 'Done',
                                      fontSize: TextSize.lBody,
                                    );
                            })),
                      ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
