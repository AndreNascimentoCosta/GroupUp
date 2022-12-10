import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/models/top_bar_individual_group.dart';
import 'package:groupup/styles/standard_text.dart';

class ObjectiveRewardModel extends StatelessWidget {
  ObjectiveRewardModel({required this.topBarIndividualGroup, required this.icon, required this.text});

  final TopBarIndividualGroupModel topBarIndividualGroup;
  String icon;
  String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ImageIcon(
          AssetImage(
            icon,
          ),
        ),
        const SizedBox(
          height: kDefaultPadding / 2,
        ),
        StandardTextStyle(text: text),
      ],
    );
  }
}
