import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/screens/individual_group/components/individual_card.dart';
import 'package:groupup/models/home_view.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:provider/provider.dart';

class BodyIndividualGroup extends StatelessWidget {
  const BodyIndividualGroup({
    required this.homeViewModel,
  });

  final HomeViewModel homeViewModel;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scrollbar(
        child: Builder(
          builder: (context) {
            final participants = Provider.of<IndividualGroupProvider>(context)
                .group
                ?.participantsData;
            if (participants == null) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.only(
                top: kDefaultPadding / 2,
              ),
              separatorBuilder: (context, index) => const Divider(
                indent: kDefaultPadding,
                endIndent: kDefaultPadding,
                height: 20,
                thickness: 0.5,
                color: kSecondaryColor,
              ),
              itemCount: participants.length,
              itemBuilder: (context, index) => IndividualGroupCard(
                participant: participants[index],
                homeViewModel: homeViewModel,
              ),
            );
          },
        ),
      ),
    );
  }
}
