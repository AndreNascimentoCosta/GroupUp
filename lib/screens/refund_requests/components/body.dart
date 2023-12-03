import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/widgets/texts/gu_text_body.dart';
import 'package:groupup/models/group_model.dart';
import 'package:groupup/screens/refund_requests/components/individual_card.dart';

class BodyRefundRequests extends StatelessWidget {
  const BodyRefundRequests({required this.groupsData});

  final List<GroupModel> groupsData;

  @override
  Widget build(BuildContext context) {
    if (groupsData.isEmpty) {
      return const Expanded(
        child: Padding(
          padding: EdgeInsets.only(top: kDefaultPadding),
          child: Align(
            alignment: Alignment.topCenter,
            child: GUTextBody(
              text: 'No refund requests',
              color: GPColors.secondaryColor,
              textAlign: TextAlign.center,
              minFontSize: 20,
              maxFontSize: 20,
            ),
          ),
        ),
      );
    } else {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Scrollbar(
            child: ListView.separated(
              padding: const EdgeInsets.only(
                top: kDefaultPadding / 2,
              ),
              separatorBuilder: (context, index) => const Padding(
                padding: EdgeInsets.only(top: kDefaultPadding),
              ),
              itemCount: groupsData.length,
              itemBuilder: (context, index) {
                return IndividualRefundRequest(
                  groupModel: groupsData[index],
                );
              },
            ),
          ),
        ),
      );
    }
  }
}
