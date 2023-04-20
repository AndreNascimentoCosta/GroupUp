import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/models/group_model.dart';
import 'package:groupup/screens/balance/components/individual_card.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GroupsBalance extends StatelessWidget {
  const GroupsBalance({required this.groupsData});

  final List<GroupModel> groupsData;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;
    final appLocalizations = AppLocalizations.of(context);
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
                child: CircularProgressIndicator.adaptive(),
              );
            }
            if (snapshot.data!.docs.isEmpty) {
              return Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: kDefaultPadding),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: StaticText(
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
              final groups = snapshot.data!.docs
                  .map((e) => GroupModel.fromMap(e.id, e.data()))
                  .toList();
              return ListView.separated(
                padding: const EdgeInsets.only(
                  top: kDefaultPadding / 2,
                  left: kDefaultPadding,
                  right: kDefaultPadding,
                ),
                separatorBuilder: (context, index) => const Padding(
                  padding: EdgeInsets.only(top: kDefaultPadding),
                ),
                itemCount: groups.length,
                itemBuilder: (context, index) {
                  return IndividualCardBalance(
                    group: groups[index],
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
