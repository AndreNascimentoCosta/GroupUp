import 'package:flutter/material.dart';
import 'package:groupup/screens/edit_profile/edit_fields/edit_name/components/app_bar.dart';
import 'package:groupup/screens/edit_profile/edit_fields/edit_name/components/body.dart';

class EditNameScreen extends StatelessWidget {
  const EditNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarEditName(),
      body: SingleChildScrollView(child: EditNameBody()),
    );
  }
}