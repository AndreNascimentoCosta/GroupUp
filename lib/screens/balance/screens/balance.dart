import 'package:flutter/material.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/group.dart';
import 'package:groupup/screens/balance/components/app_bar.dart';
import 'package:groupup/screens/balance/components/body.dart';
import 'package:groupup/screens/balance/components/search_bar.dart';
import 'package:groupup/screens/balance/components/header.dart';

class BalanceScreen extends StatelessWidget {
  const BalanceScreen({required this.groupsData});

  final List<GroupModel> groupsData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarBalance(),
      body: Column(
        children: [
          const HeaderBalance(),
          const SizedBox(height: Insets.s),
          const SearchBar(),
          const SizedBox(height: Insets.s),
          GroupsBalance(groupsData: groupsData,),
        ],
      ),
    );
  }
}