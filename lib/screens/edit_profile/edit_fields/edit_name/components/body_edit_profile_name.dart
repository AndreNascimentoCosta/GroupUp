import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/screens/edit_profile/components/text_field.dart';
import 'package:groupup/core/providers/edit_profile_name_provider.dart';
import 'package:provider/provider.dart';

class EditProfileNameBody extends StatelessWidget {
  const EditProfileNameBody({super.key});

  @override
  Widget build(BuildContext context) {
    var editProfileNameController =
        Provider.of<EditProfileNameProvider>(context).profileNameController;
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: kDefaultPadding,
        horizontal: kDefaultPadding,
      ),
      child: SizedBox(
        height: 70,
        width: 400,
        child: TextFieldModel(
          controller: editProfileNameController,
          hint: '',
          validator: (value) {
            if (value!.isNotEmpty && value.length < 3) {
              return 'Name must be at least 3 characters';
            } else if (value.length >= 30) {
              return 'Name must be less than 30 characters';
            } else {
              return null;
            }
          },
          maxLength: 30,
          border: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: kSecondaryColor,
              width: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}
