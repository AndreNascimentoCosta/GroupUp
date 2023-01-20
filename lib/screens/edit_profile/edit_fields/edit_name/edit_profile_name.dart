import 'package:flutter/material.dart';
import 'package:groupup/screens/edit_profile/edit_fields/edit_name/components/app_bar_edit_profile_name.dart';
import 'package:groupup/screens/edit_profile/edit_fields/edit_name/components/body_edit_profile_name.dart';
import 'package:groupup/screens/edit_profile/edit_fields/edit_name/edit_profile_name_provider.dart';
import 'package:provider/provider.dart';

class EditNameScreen extends StatelessWidget {
  const EditNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EditProfileNameProvider(),
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: const Scaffold(
          appBar: AppBarEditProfileName(),
          body: SingleChildScrollView(
            child: EditProfileNameBody(),
          ),
        ),
      ),
    );
  }
}
