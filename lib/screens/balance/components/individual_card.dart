import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/large_body.dart';
import 'package:groupup/core/widgets/texts/medium_body.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/group_model.dart';

class IndividualCardBalance extends StatelessWidget {
  const IndividualCardBalance({required this.groups});

  final GroupModel groups;

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
          child: ClipRRect(
            borderRadius: BorderRadius.circular(37.5),
            child: groups.image.isNotEmpty
                ? Image.network(
                    groups.image,
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    'assets/icons/profile2.png',
                    height: 50,
                    width: 50,
                  ),
          ),
        ),
        const SizedBox(width: Insets.m),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LargeBody(
              text: groups.projectName.replaceAll(RegExp('#'), ''),
              fontFamily: 'Montserrat-SemiBold',
            ),
            const SizedBox(height: Insets.s),
            const MediumBody(
              text: 'Ended',
              color: kSecondaryColor,
            ),
          ],
        ),
        const Spacer(),
        const Padding(
          padding: EdgeInsets.only(right: kDefaultPadding),
          child: LargeBody(
            text: '\$200.00',
            color: Colors.green,
          ),
        ),
      ],
    );
  }
}
