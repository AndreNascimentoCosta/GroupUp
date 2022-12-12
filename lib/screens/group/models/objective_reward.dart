import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/models/general_group_info.dart';
import 'package:groupup/styles/standard_text.dart';

class ObjectiveRewardModel extends StatelessWidget {
  ObjectiveRewardModel(
      {required this.generalGroupInfoModel,
      required this.icon,
      required this.text});

  final GeneralGroupInfoModel generalGroupInfoModel;
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
        SizedBox(
          width: 65,
          child: StandardTextStyle(
            text: text,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
