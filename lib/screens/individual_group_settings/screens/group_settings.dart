import 'package:flutter/material.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/models/group_model.dart';
import 'package:groupup/models/home_view.dart';
import 'package:groupup/screens/individual_group_settings/components/app_bar.dart';
import 'package:groupup/screens/individual_group_settings/components/body_admin.dart';
import 'package:groupup/screens/individual_group_settings/components/body_not_admin.dart';
import 'package:provider/provider.dart';

class GroupSettings extends StatelessWidget {
  const GroupSettings({
    required this.homeViewModel,
    required this.groups,
  });

  final HomeViewModel homeViewModel;
  final GroupModel groups;

  @override
  Widget build(BuildContext context) {
    final individualGroupProvider = Provider.of<IndividualGroupProvider>(
      context,
      listen: false,
    );
    final currentUserId = Provider.of<AuthProvider>(context).user?.id;
     if (individualGroupProvider.group != null) {
      final currentUserData =
          individualGroupProvider.group!.participantsData.firstWhere(
        (element) => element.uid == currentUserId,
      );
      if (currentUserData.isAdmin) {
        return Scaffold(
          appBar: AppBarGroupSettings(
            homeViewModel: homeViewModel,
          ),
          body: BodyAdminSettings(
            groups: groups,
          ),
        );
      } else {
        return Scaffold(
          appBar: AppBarGroupSettings(
            homeViewModel: homeViewModel,
          ),
          body: BodyNotAdminSettings(
            groups: groups,
          ),
        );
      }
    } return const Scaffold();
  }
}
