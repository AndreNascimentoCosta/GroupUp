import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/models/show_group.dart';
import 'package:groupup/models/home_view.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/screens/groups/components/checkbox.dart';
import 'package:groupup/screens/groups/components/stats.dart';

class GroupsCard extends StatefulWidget {
  const GroupsCard({
    Key? key,
    required this.showGroup,
    required this.homeViewModel,
  }) : super(key: key);

  final ShowGroupModel showGroup;
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
          const SizedBox();
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
            ClipRRect(
              borderRadius: BorderRadius.circular(37.5),
              child: widget.showGroup.image.isNotEmpty
                  ? Image.network(
                      widget.showGroup.image,
                      height: 75,
                      width: 75,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/icons/profile2.png',
                      height: 75,
                      width: 75,
                    ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: kDefaultPadding,
                ),
                child: StaticText(
                  text: Characters(widget.showGroup.projectName)
                      .replaceAll(Characters(''), Characters('\u{200B}'))
                      .toString(),
                  overflow: TextOverflow.ellipsis,
                  fontSize: 20,
                ),
              ),
            ),
            StatsGroup(
              showGroup: widget.showGroup,
              homeViewModel: widget.homeViewModel,
            ),
          ],
        ),
      ),
    );
  }
}
