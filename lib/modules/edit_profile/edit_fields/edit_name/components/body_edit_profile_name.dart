import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/modules/edit_profile/components/text_field.dart';
import 'package:groupup/core/providers/edit_profile_name_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditProfileNameBody extends StatelessWidget {
  const EditProfileNameBody({super.key});

  @override
  Widget build(BuildContext context) {
    var editProfileNameController =
        Provider.of<EditProfileNameProvider>(context).profileNameController;
    final appLocalizations = AppLocalizations.of(context)!;
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
              return appLocalizations.nameValidatorMinChars;
            } else if (value.length >= 30) {
              return appLocalizations.nameValidatorMaxChars;
            } else {
              return null;
            }
          },
          maxLength: 30,
          border: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: GPColors.secondaryColor,
              width: 0.5,
            ),
          ),
          inputFormatters: [
            if (editProfileNameController.text.isEmpty)
              FilteringTextInputFormatter.deny(
                RegExp(r' '),
              )
          ],
        ),
      ),
    );
  }
}
