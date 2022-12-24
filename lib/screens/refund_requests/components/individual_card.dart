import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/large_body.dart';
import 'package:groupup/core/widgets/texts/medium_body.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/group.dart';

class IndividualRefundRequest extends StatelessWidget {
  const IndividualRefundRequest({required this.groupModel});

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
            LargeBody(
              text: Characters(groupModel.title.replaceAll(RegExp('#'), '')).
                      replaceAll(Characters(''), Characters('\u{200B}')).toString(),
              overflow: TextOverflow.ellipsis,
              fontFamily: 'Montserrat-SemiBold',
            ),
            const SizedBox(height: Insets.s),
            const MediumBody(text: 'Request denied', color: kSecondaryColor,)
          ],
        ),
        const Spacer(),
        const Padding(
          padding: EdgeInsets.only(right: kDefaultPadding),
          child: LargeBody(text: '-'),
        ),
      ],
    );
  }
}
