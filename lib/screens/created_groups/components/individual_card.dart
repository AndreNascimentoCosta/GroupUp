import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/extra_large_body.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/group.dart';
import 'package:groupup/screens/created_groups/components/dates.dart';

class IndividualCreatedGroup extends StatelessWidget {
  const IndividualCreatedGroup({required this.groupModel});

  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Row(
        children: [
          CircleAvatar(
            radius: 37.5,
            backgroundImage: AssetImage(groupModel.image),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: kDefaultPadding,
              ),
              child: ExtraLargeBody(
                text: groupModel.title,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const SizedBox(width: Insets.s),
          ShowDates(
            generalGroupInfoModel: groupModel.generalGroupInfoModel,
          )
        ],
      ),
    );
  }
}
