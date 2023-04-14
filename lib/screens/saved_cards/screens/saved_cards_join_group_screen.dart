import 'package:flutter/material.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/screens/saved_cards/components/saved_cards_app_bar.dart';
import 'package:groupup/screens/saved_cards/components/saved_cards_body.dart';

class SavedCardsScreen extends StatelessWidget {
  const SavedCardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GPColors.white,
      appBar: const AppBarSavedCards(),
      body: Column(
        children: const [
          BodySavedCards(),
        ],
      ),
    );
  }
}
