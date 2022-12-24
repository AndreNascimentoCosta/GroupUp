import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/extra_large_body.dart';
import 'package:groupup/models/group.dart';
import 'package:groupup/screens/individual_group/screens/individual_group.dart';
import 'package:groupup/models/home_view.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/screens/groups/components/checkbox.dart';
import 'package:groupup/screens/groups/components/stats.dart';

class GroupsCard extends StatefulWidget {
  const GroupsCard({
    Key? key,
    required this.groupModel,
    required this.press,
    required this.homeViewModel,
  }) : super(key: key);

  final GroupModel groupModel;
  final VoidCallback press;
  final HomeViewModel homeViewModel;

  @override
  State<GroupsCard> createState() => _GroupsCardState();
}

class _GroupsCardState extends State<GroupsCard> {
  bool isChecked = false;
  final CheckBoxGroup checkBoxGroup = CheckBoxGroup();

  @override
  Widget build(BuildContext context) {
    return ButtonCommonStyle(
      onPressed: () {
        if (widget.homeViewModel.isEditing.value) {
          setState(() {
            isChecked = !isChecked;
          });
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => IndividualGroupScreen(
                homeViewModel: widget.homeViewModel,
                groupModel: widget.groupModel,
              ),
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Row(
          children: [
            ValueListenableBuilder(
              valueListenable: widget.homeViewModel.isEditing,
              builder: (context, value, child) {
                return AnimatedContainer(
                  width: value ? 50 : 0,
                  duration: const Duration(milliseconds: 50),
                  child: Visibility(
                    visible: value,
                    child: CheckBoxGroup(
                      isChecked: isChecked,
                    ),
                  ),
                );
              },
            ),
            CircleAvatar(
              radius: 37.5,
              backgroundImage: AssetImage(widget.groupModel.image),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: kDefaultPadding,
                ),
                child: ExtraLargeBody(
                  text: Characters(widget.groupModel.title)
                      .replaceAll(Characters(''), Characters('\u{200B}'))
                      .toString(),
                ),
              ),
            ),
            StatsGroup(
              groupModel: widget.groupModel,
              press: widget.press,
              homeViewModel: widget.homeViewModel,
            ),
          ],
        ),
      ),
    );
  }
}
