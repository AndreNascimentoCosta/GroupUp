import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/group.dart';
import 'package:groupup/styles/text.dart';

class SingleGroupBalance extends StatelessWidget {
  const SingleGroupBalance({required this.groupModel});

  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                blurRadius: 7,
                color: kSecondaryColor,
                spreadRadius: 0.2,
              ),
            ],
          ),
          child: CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage(groupModel.image),
          ),
        ),
        const SizedBox(width: Insets.m),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StandardTextStyle(
              text: groupModel.title.replaceAll(RegExp('#'), ''),
              fontFamily: 'Montserrat-SemiBold',
              fontSize: TextSize.lBody,
            ),
            const SizedBox(height: Insets.s),
            const StandardTextStyle(
              text: 'Ongoing',
              fontSize: 16,
              color: Color(0XFF767676),
            ),
          ],
        ),
        const Spacer(),
        const Padding(
          padding: EdgeInsets.only(right: kDefaultPadding),
          child: StandardTextStyle(
            text: '-',
            fontSize: TextSize.lBody,
          ),
        ),
      ],
    );
  }
}
