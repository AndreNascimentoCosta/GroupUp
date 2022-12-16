import 'package:flutter/material.dart';
import 'package:groupup/screens/balance/components/app_bar_balance.dart';
import 'package:groupup/screens/balance/components/groups_balance.dart';
import 'package:groupup/screens/balance/components/search_bar.dart';
import 'package:groupup/screens/balance/components/top_bar_balance.dart';

class BalanceScreen extends StatelessWidget {
  const BalanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarBalance(),
      body: Column(
        children: const [
          TopBarBalance(),
          SearchBar(),
          GroupsBalance(),
        ],
      ),
    );
  }
}