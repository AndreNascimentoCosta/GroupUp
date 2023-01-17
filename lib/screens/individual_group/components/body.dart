import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/models/group_model.dart';
import 'package:groupup/screens/individual_group/components/individual_card.dart';
import 'package:groupup/models/home_view.dart';

class BodyIndividualGroup extends StatelessWidget {
  const BodyIndividualGroup({
    required this.homeViewModel,
    required this.group,
  });

  final HomeViewModel homeViewModel;
  final GroupModel group;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scrollbar(
        child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance
              .collection('groups')
              .doc(group.id)
              .get(),
          builder: ((context, snapshot) {
            final docData = snapshot.data?.data();
            final docId = snapshot.data?.id;
            if (docData == null || docId == null) {
              return const Center(
                child: CircularProgressIndicator(color: kPrimaryColor),
              );
            }
            final participants =
                GroupModel.fromMap(docId, docData).participantsData;

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
                meParticipant: participants[index],
              ),
            );
          }),
        ),
      ),
    );
  }
}
