import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/providers/edit_group_fields_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/constants/design_system.dart';
import 'package:groupup/core/widgets/text_field/gp_edit_text_field.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditGroupNameBody extends StatelessWidget {
  const EditGroupNameBody({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final editGroupFieldsProvider =
        Provider.of<EditGroupFieldsProvider>(context).groupNameController;
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: kDefaultPadding,
        horizontal: kDefaultPadding,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 70,
              width: 400,
              child: GPEditTextField(
                controller: editGroupFieldsProvider,
                hint: '',
                maxLength: 30,
                validator: (value) {
                  if (value!.isNotEmpty && value.length < 3) {
                    return appLocalizations.projectNameValidatorMinChars;
                  } else if (value.length >= 20) {
                    return appLocalizations.projectNameValidatorMaxChars;
                  } else {
                    return null;
                  }
                },
                border: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: GPColors.secondaryColor,
                    width: 0.5,
                  ),
                ),
                inputFormatters: [
                  if (editGroupFieldsProvider.text.isEmpty)
                    FilteringTextInputFormatter.deny(
                      RegExp(r' '),
                    )
                ],
              ),
            ),
            const SizedBox(height: Insets.l),
            GPTextBody(text: appLocalizations.changeGroupName),
          ],
        ),
      ),
    );
  }
}
