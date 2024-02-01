import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/widgets/loading/gp_loading.dart';
import 'package:groupup/core/widgets/texts/gp_text_title.dart';
import 'package:groupup/models/group_model.dart';
import 'package:groupup/models/home_view.dart';
import 'package:groupup/modules/groups/components/group_card.dart';
import 'package:groupup/modules/groups/components/no_group.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({
    required this.homeViewModel,
  });

  final HomeViewModel homeViewModel;

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      backgroundColor: GPColors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: GPColors.white,
        automaticallyImplyLeading: false,
        title: GPTextTitle(
          text: AppLocalizations.of(context)!.groups,
        ),
        centerTitle: false,
      ),
      body: Scrollbar(
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('groups')
              .orderBy(
                'createdAt',
                descending: true,
              )
              .where(
                'participants',
                arrayContains: userId,
              )
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData == false) {
              return const GPLoading();
            }
            if (snapshot.data!.docs.isEmpty) {
              return const Column(
                children: [
                  NoGroup(),
                ],
              );
            } else {
              final groups = snapshot.data!.docs
                  .map(
                    (e) => GroupModel.fromMap(
                      e.id,
                      e.data(),
                    ),
                  )
                  .toList();
              return ListView.separated(
                padding: const EdgeInsets.only(
                  top: kDefaultPadding / 2,
                  bottom: kDefaultPadding,
                ),
                separatorBuilder: (
                  context,
                  index,
                ) =>
                    const Divider(
                  indent: kDefaultPadding,
                  endIndent: kDefaultPadding,
                  height: kDefaultPadding,
                  thickness: 0.5,
                  color: GPColors.secondaryColor,
                ),
                itemCount: groups.length,
                itemBuilder: (
                  context,
                  index,
                ) =>
                    GroupCard(
                  homeViewModel: homeViewModel,
                  group: groups[index],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
