import 'package:flutter/material.dart';
import 'package:groupup/screens/saved_cards/components/saved_cards_app_bar.dart';
import 'package:groupup/screens/saved_cards/components/saved_cards_body.dart';

class SavedCardsScreen extends StatelessWidget {
  const SavedCardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarSavedCards(),
      body: Column(
        children: const [
          BodySavedCards(),
        ],
      ),
    );
  }
}
