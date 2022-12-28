import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/models/group.dart';
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
            child: StaticText(
              text: 'No refund requests',
              color: kSecondaryColor,
              textAlign: TextAlign.center,
              fontSize: 20,
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
