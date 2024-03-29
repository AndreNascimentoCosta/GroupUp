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

class EditGroupObjectiveBody extends StatelessWidget {
  const EditGroupObjectiveBody({super.key});

  @override
  Widget build(BuildContext context) {
    final groupFieldsController =
        Provider.of<EditGroupFieldsProvider>(context)
            .groupObjectiveController;
    final appLocalizations = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: kDefaultPadding,
        horizontal: kDefaultPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 70,
            width: 400,
            child: GPEditTextField(
              controller: groupFieldsController,
              hint: '',
              validator: (value) {
                if (value!.isNotEmpty && value.length < 3) {
                  return appLocalizations.objectiveValidatorMinChars;
                } else if (value.length >= 50) {
                  return appLocalizations.objectiveValidatorMaxChars;
                } else {
                  return null;
                }
              },
              maxLength: 50,
              border: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: GPColors.secondaryColor,
                  width: 0.5,
                ),
              ),
              inputFormatters: [
                if (groupFieldsController.text.isEmpty)
                  FilteringTextInputFormatter.deny(
                    RegExp(r' '),
                  )
              ],
            ),
          ),
          const SizedBox(height: Insets.l),
          GPTextBody(text: appLocalizations.changeGroupObjective),
        ],
      ),
    );
  }
}
