import 'package:flutter/material.dart';
import 'package:groupup/screens/edit_profile/components/app_bar.dart';
import 'package:groupup/screens/edit_profile/components/body.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarEditProfile(),
      body: SingleChildScrollView(
        child: EditProfileBody(),
      ),
    );
  }
}
