import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/models/group_model.dart';
import 'package:groupup/models/participant.dart';
import 'package:groupup/screens/individual_group/components/individual_card.dart';
import 'package:groupup/models/home_view.dart';

class BodyIndividualGroup extends StatelessWidget {
  const BodyIndividualGroup(
      {required this.homeViewModel});

  final HomeViewModel homeViewModel;

  @override
  Widget build(BuildContext context) {
    final List<Participant> participant = [];
    return Expanded(
      child: Scrollbar(
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            builder: ((context, snapshot) {
          if (snapshot.hasData == false) {
            return const Center(
              child: CircularProgressIndicator(color: kPrimaryColor),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return const SizedBox();
          } else {
            final groups = snapshot.data!.docs
                .map((e) => GroupModel.fromMap(e.data()))
                .toList();
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
              itemCount: groups.length,
              itemBuilder: (context, index) => IndividualGroupCard(
                participant: participant[index],
                homeViewModel: homeViewModel,
                meParticipant: participant[index],
              ),
            );
          }
        })),
      ),
    );
  }
}
