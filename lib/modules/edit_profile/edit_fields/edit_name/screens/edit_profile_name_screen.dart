import 'package:flutter/material.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/providers/edit_profile_name_provider.dart';
import 'package:groupup/modules/edit_profile/edit_fields/edit_name/components/body_edit_profile_name.dart';
import 'package:groupup/modules/edit_profile/edit_fields/edit_name/components/edit_profile_name_app_bar.dart';
import 'package:provider/provider.dart';

class EditNameScreen extends StatelessWidget {
  const EditNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;
    if (user == null) return const SizedBox();
    final name = user.name;
    return ChangeNotifierProvider(
      create: (context) => EditProfileNameProvider(name),
      child: const PopScope(
        canPop: false,
        child: Scaffold(
          appBar: EditProfileNameAppBar(),
          body: SingleChildScrollView(
            child: EditProfileNameBody(),
          ),
        ),
      ),
    );
  }
}
