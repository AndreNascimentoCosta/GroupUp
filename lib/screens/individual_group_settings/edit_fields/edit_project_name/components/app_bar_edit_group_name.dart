import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/header.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/models/group_model.dart';
import 'package:groupup/core/providers/edit_group_name_provider.dart';
import 'package:provider/provider.dart';

class AppBarEditGroupName extends StatelessWidget with PreferredSizeWidget {
  const AppBarEditGroupName({required this.groups});

  final GroupModel groups;

  @override
  Widget build(BuildContext context) {
    final editGroupNameProvider = Provider.of<EditGroupNameProvider>(context);
    return SafeArea(
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.centerStart,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
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
                child: const Header(text: 'Group name'),
              ),
              ButtonCommonStyle(
                onPressed: () {
                  if (editGroupNameProvider.groupNameController.text == groups.projectName) {
                    Navigator.pop(context);
                  } else {
                    editGroupNameProvider.confirmDiscard(context);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: kDefaultPadding),
                  child: GestureDetector(
                    child: Container(
                      color: Colors.transparent,
                      width: Insets.l * 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/arrow_left.svg',
                            height: Insets.l * 1.25,
                            width: Insets.l * 1.25,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: kDefaultPadding,
                child: Padding(
                  padding: const EdgeInsets.only(left: kDefaultPadding),
                  child: ButtonCommonStyle(
                    onPressed: editGroupNameProvider.done(
                        context, groups.projectName, groups.id),
                    child: StaticText(
                      text: 'Done',
                      fontSize: TextSize.lBody,
                      fontFamily: 'Montserrat-SemiBold',
                      color: editGroupNameProvider.done(
                                  context, groups.projectName, groups.id) ==
                              null
                          ? kSecondaryColor
                          : Colors.black,
                    ),
                  ),
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
