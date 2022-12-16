import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/group.dart';
import 'package:groupup/styles/text.dart';

class MaxNumberParticipants extends StatelessWidget {
  const MaxNumberParticipants({required this.groupModel});

  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: () {},
            backgroundColor: kPrimaryColor,
            elevation: 0,
            child: const ImageIcon(
              AssetImage('assets/icons/minus_participant.png'),
              size: 30,
            ),
          ),
          const SizedBox(width: Insets.l * 2),
          StandardTextStyle(
            text: (groupModel.userInformation.length + 1).toString(),
            fontSize: TextSize.subTitle,
          ),
          const SizedBox(width: Insets.l * 2),
          FloatingActionButton(
            onPressed: () {},
            backgroundColor: kPrimaryColor,
            elevation: 0,
            child: const ImageIcon(
              AssetImage('assets/icons/add_participant.png'),
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
