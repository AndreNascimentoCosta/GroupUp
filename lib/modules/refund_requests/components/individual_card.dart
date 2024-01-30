import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';
import 'package:groupup/core/constants/design-system.dart';
import 'package:groupup/models/group_model.dart';

class IndividualRefundRequest extends StatelessWidget {
  const IndividualRefundRequest({required this.groupModel});

  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: GPColors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                blurRadius: 7,
                color: GPColors.secondaryColor,
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
            GPTextBody(
              text:
                  Characters(groupModel.projectName.replaceAll(RegExp('#'), ''))
                      .replaceAll(Characters(''), Characters('\u{200B}'))
                      .toString(),
              overflow: TextOverflow.ellipsis,
              fontFamily: 'Montserrat-SemiBold',
              fontSize: 16,
            ),
            const SizedBox(height: Insets.s),
            const GPTextBody(
              text: 'Request denied',
              color: GPColors.secondaryColor,
            )
          ],
        ),
        const Spacer(),
        const Padding(
          padding: EdgeInsets.only(right: kDefaultPadding),
          child: GPTextBody(
            text: '-',
              fontSize: 16,
          ),
        ),
      ],
    );
  }
}
