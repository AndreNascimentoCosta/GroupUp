import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/models/show_group.dart';
import 'package:groupup/screens/groups/components/app_bar.dart';
import 'package:groupup/screens/groups/components/group_card.dart';
import 'package:groupup/models/home_view.dart';
import 'package:groupup/screens/groups/components/no_group.dart';
import 'package:groupup/screens/home/components/bottom_sheet/sign_up/auth_provider.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  const Body({
    required this.homeViewModel,
    required this.showGroup,
  });

  final HomeViewModel homeViewModel;
  final List<ShowGroupModel> showGroup;

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarGroup(
        homeViewModel: homeViewModel,
        showGroup: showGroup,
      ),
      body: Scrollbar(
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('groups')
              .where(
                'participants',
                arrayContains: userId,
              )
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData == false) {
              return const Center(
                child: CircularProgressIndicator(color: kPrimaryColor),
              );
            }
            if (snapshot.data!.docs.isEmpty) {
              return Column(children:  const [NoGroup()]);
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
                itemBuilder: (context, index) => GroupsCard(
                  homeViewModel: homeViewModel,
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
