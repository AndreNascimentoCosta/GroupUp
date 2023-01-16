import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/models/show_group.dart';
import 'package:groupup/screens/created_groups/components/individual_card.dart';

class BodyCreatedGroup extends StatelessWidget {
  const BodyCreatedGroup({required this.showGroup});

  final List<ShowGroupModel> showGroup;

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    return Expanded(
      child: Scrollbar(
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance.collection('groups').where(
            'participantsData',
            arrayContainsAny: [
              {
                'userId': userId,
                'role': 'creator',
              },
            ],
          ).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData == false) {
              return const Center(
                child: CircularProgressIndicator(color: kPrimaryColor),
              );
            }
            if (snapshot.data!.docs.isEmpty) {
              return Column(
                children: const [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: kDefaultPadding),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: StaticText(
                          text: 'No created groups',
                          color: kSecondaryColor,
                          textAlign: TextAlign.center,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              final groups = snapshot.data!.docs
                  .map((e) => ShowGroupModel.fromJson(e.data()))
                  .toList();
              return ListView.separated(
                padding: const EdgeInsets.only(
                  top: kDefaultPadding / 2,
                ),
                separatorBuilder: (context, index) => const Divider(
                  indent: kDefaultPadding,
                  endIndent: kDefaultPadding,
                  height: kDefaultPadding,
                  thickness: 0.5,
                  color: kSecondaryColor,
                ),
                itemCount: groups.length,
                itemBuilder: (context, index) => IndividualCreatedGroup(
                  showGroup: groups[index],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
