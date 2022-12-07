import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/models/group.dart';
import 'package:groupup/screens/group/individual_group_screen.dart';
import 'package:groupup/screens/groups/components/home_view_model.dart';
import 'package:groupup/screens/groups/components/stats_group.dart';

class GroupsCard extends StatefulWidget {
  const GroupsCard(
      {Key? key,
      required this.groupModel,
      required this.press,
      required this.homeViewModel})
      : super(key: key);

  final GroupModel groupModel;
  final VoidCallback press;
  final HomeViewModel homeViewModel;

  @override
  State<GroupsCard> createState() => _GroupsCardState();
}

class _GroupsCardState extends State<GroupsCard> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => IndividualGroupScreen(homeViewModel: widget.homeViewModel, groupModel: widget.groupModel,),
          ),
        );
      }),
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
                    child: Checkbox(
                      value: isChecked,
                      activeColor: kPrimaryColor,
                      shape: const CircleBorder(),
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
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
                child: Text(
                  widget.groupModel.title,
                  style: const TextStyle(
                    fontSize: kDefaultPadding,
                    fontFamily: 'Montserrat-Medium',
                  ),
                ),
              ),
            ),
            StatsGroup(groupModel: widget.groupModel, press: widget.press, homeViewModel: widget.homeViewModel,),
          ],
        ),
      ),
    );
  }
}
