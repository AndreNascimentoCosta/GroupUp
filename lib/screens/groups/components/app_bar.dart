import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/models/show_group.dart';
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
      title: const StaticText(
        text: 'Groups',
        fontFamily: 'Montserrat-Bold',
        fontSize: TextSize.title,
      ),
      centerTitle: false,
      actions: [
        StreamBuilder(
            stream: FirebaseFirestore.instance.collection('groups').snapshots(),
            builder: ((context, snapshot) {
              return Padding(
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
                                    final groups = snapshot.data!.docs
                                        .map((e) =>
                                            ShowGroupModel.fromJson(e.data()))
                                        .toList();
                                    if (selectItems.length == groups.length) {
                                      selectItems.clear();
                                    } else {
                                      for (int index = 0;
                                          index < groups.length;
                                          index++) {
                                        selectItems.add(groups[index]);
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
                      !snapshot.hasData
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
                                }),
                              ),
                            ),
                    ],
                  ),
                ),
              );
            })),
      ],
    );
  }
}
