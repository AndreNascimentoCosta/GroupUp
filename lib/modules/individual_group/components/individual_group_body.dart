import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/widgets/loading/gp_loading.dart';
import 'package:groupup/modules/individual_group/components/individual_group_card.dart';
import 'package:groupup/models/home_view_model.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:provider/provider.dart';

class IndividualGroupBody extends StatelessWidget {
  const IndividualGroupBody({
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
              return const GPLoading();
            }
            return ListView.separated(
              padding: const EdgeInsets.only(
                top: kDefaultPadding / 2,
                bottom: kDefaultPadding * 18,
              ),
              separatorBuilder: (context, index) => const Divider(
                indent: kDefaultPadding,
                endIndent: kDefaultPadding,
                height: 20,
                thickness: 0.5,
                color: GPColors.secondaryColor,
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
