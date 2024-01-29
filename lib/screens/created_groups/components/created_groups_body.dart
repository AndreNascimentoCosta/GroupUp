import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';
import 'package:groupup/models/group_model.dart';
import 'package:groupup/screens/created_groups/components/individual_card.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BodyCreatedGroup extends StatelessWidget {
  const BodyCreatedGroup({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;
    final appLocalizations = AppLocalizations.of(context)!;
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
            final groups = snapshot.data?.docs
                .map((e) => GroupModel.fromMap(e.id, e.data()))
                .toList()
                .where(
                  (element) => element.participantsData
                      .where((element) => element.uid == user?.id)
                      .first
                      .isAdmin,
                )
                .toList();
            if (snapshot.hasData == false) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            if (snapshot.data!.docs.isEmpty || groups!.isEmpty) {
              return Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: kDefaultPadding),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: GPTextBody(
                          text: appLocalizations.noCreatedGroups,
                          color: GPColors.secondaryColor,
                          textAlign: TextAlign.center,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return ListView.separated(
                padding: const EdgeInsets.only(
                  top: kDefaultPadding / 2,
                ),
                separatorBuilder: (context, index) => const Divider(
                  indent: kDefaultPadding,
                  endIndent: kDefaultPadding,
                  height: kDefaultPadding,
                  thickness: 0.5,
                  color: GPColors.secondaryColor,
                ),
                itemCount: groups.length,
                itemBuilder: (context, index) => IndividualCreatedGroup(
                  group: groups.elementAt(index),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
