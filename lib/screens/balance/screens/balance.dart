import 'package:flutter/material.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/balance/components/app_bar.dart';
import 'package:groupup/screens/balance/components/body.dart';
import 'package:groupup/screens/balance/components/search_bar.dart';
import 'package:groupup/screens/balance/components/header.dart';

class BalanceScreen extends StatelessWidget {
  const BalanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarBalance(),
      body: Column(
        children: const [
          HeaderBalance(),
          SizedBox(height: Insets.s),
          SearchBar(),
          SizedBox(height: Insets.s),
          GroupsBalance(),
        ],
      ),
    );
  }
}