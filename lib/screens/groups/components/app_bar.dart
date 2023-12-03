import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/constants/design-system.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/widgets/texts/gu_text_body.dart';
import 'package:groupup/core/widgets/texts/gu_text_title.dart';
import 'package:groupup/models/group_model.dart';
import '../../../models/home_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppBarGroup extends StatefulWidget implements PreferredSizeWidget {
  const AppBarGroup({required this.homeViewModel});

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
      backgroundColor: GPColors.white,
      automaticallyImplyLeading: false,
      title: GUTextTitle(
        text: AppLocalizations.of(context).groups,
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
                                          GroupModel.fromMap(e.id, e.data()))
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
                              child: GUTextBody(
                                text: AppLocalizations.of(context).selectAll,
                                minFontSize: 18,
                                maxFontSize: 18,
                              ),
                            ),
                          );
                        }),
                    const SizedBox(width: Insets.l),
                    // !snapshot.hasData
                    //     ? const StaticText(
                    //         text: 'Edit',
                    //         fontSize: TextSize.lBody,
                    //         color: GPColors.secondaryColor,
                    //       )
                    //     : ButtonCommonStyle(
                    //         onPressed: () {
                    //           widget.homeViewModel.switchEdit();
                    //         },
                    //         padding: const EdgeInsets.only(
                    //             bottom: kDefaultPadding / 2,
                    //             right: kDefaultPadding * 4),
                    //         child: ValueListenableBuilder(
                    //           valueListenable: widget.homeViewModel.isEditing,
                    //           builder: ((context, value, child) {
                    //             return !value
                    //                 ? const StaticText(
                    //                     text: 'Edit',
                    //                     fontSize: TextSize.lBody,
                    //                   )
                    //                 : const StaticText(
                    //                     text: 'Done',
                    //                     fontSize: TextSize.lBody,
                    //                   );
                    //           }),
                    //         ),
                    //       ),
                  ],
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
