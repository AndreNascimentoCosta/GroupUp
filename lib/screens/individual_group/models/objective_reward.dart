import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/models/general_group_info.dart';
import 'package:groupup/styles/button.dart';
import 'package:groupup/styles/ellipsis_text.dart';
import 'package:groupup/styles/text.dart';

class ObjectiveRewardModel extends StatelessWidget {
  const ObjectiveRewardModel({
    required this.generalGroupInfoModel,
    required this.icon,
    required this.text,
    required this.onPressed,
  });

  final GeneralGroupInfoModel generalGroupInfoModel;
  final String icon;
  final String text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ButtonCommonStyle(
      onPressed: onPressed,
      child: Column(
        children: [
          ImageIcon(
            AssetImage(
              icon,
            ),
            color: Colors.black,
          ),
          const SizedBox(height: kDefaultPadding / 2),
          SizedBox(
            width: 65,
            child: StandardEllipsisTextStyle(
              text: text,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
