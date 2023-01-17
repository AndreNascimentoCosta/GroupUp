import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/models/group_model.dart';
import 'package:groupup/screens/created_groups/components/individual_card.dart';
import 'package:groupup/screens/home/components/bottom_sheet/sign_up/auth_provider.dart';
import 'package:provider/provider.dart';

class BodyCreatedGroup extends StatelessWidget {
  const BodyCreatedGroup({required this.groups});

  final List<GroupModel> groups;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;
    return Expanded(
      child: Scrollbar(
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('groups')
              .orderBy('createdAt', descending: true)
              .where(
                'participants',
                arrayContains: user?.id,
              )
              .snapshots(),
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
                  .map((e) => GroupModel.fromMap(e.id, e.data()))
                  .toList()
                  .where(
                    (element) => element.participantsData
                        .where((element) => element.uid == user?.id)
                        .first
                        .isAdmin,
                  )
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
                  groups: groups.elementAt(index),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
