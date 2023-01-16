import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/extra_large_body.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/group_model.dart';
import 'package:groupup/screens/created_groups/components/dates.dart';

class IndividualCreatedGroup extends StatelessWidget {
  const IndividualCreatedGroup({
    required this.groups,
  });

  final GroupModel groups;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(37.5),
            child: groups.image.isNotEmpty
                ? Image.network(
                    groups.image,
                    height: 75,
                    width: 75,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    'assets/icons/profile2.png',
                    height: 75,
                    width: 75,
                  ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: kDefaultPadding,
              ),
              child: ExtraLargeBody(
                text: groups.projectName,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const SizedBox(width: Insets.s),
          ShowDates(
            groups: groups,
          )
        ],
      ),
    );
  }
}
