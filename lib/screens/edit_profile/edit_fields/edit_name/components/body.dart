import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/screens/edit_profile/components/text_field.dart';
import 'package:groupup/screens/edit_profile/edit_fields/edit_name/edit_name_provider.dart';
import 'package:provider/provider.dart';

class EditNameBody extends StatelessWidget {
  const EditNameBody({super.key});

  @override
  Widget build(BuildContext context) {
    var nameController = Provider.of<EditNameProvider>(context).nameController;
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: kDefaultPadding,
        horizontal: kDefaultPadding,
      ),
      child: SizedBox(
        height: 50,
        width: 400,
        child: TextFieldModel(
          controller: nameController,
          hint: '',
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
