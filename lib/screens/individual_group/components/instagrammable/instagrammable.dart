import 'package:flutter/material.dart';
import 'package:groupup/screens/individual_group/components/instagrammable/components/body_instagrammable.dart';
import 'package:groupup/screens/individual_group/components/instagrammable/components/instagrammable_button.dart';

class InstagrammableScreen extends StatelessWidget {
  const InstagrammableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: BodyInstagrammable(),
      floatingActionButton: ShareInstagrammableButton(),
    );
  }
}
