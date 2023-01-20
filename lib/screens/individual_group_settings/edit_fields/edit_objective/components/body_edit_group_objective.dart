import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/edit_profile/components/text_field.dart';
import 'package:groupup/screens/individual_group_settings/edit_fields/edit_objective/edit_group_objective_provider.dart';
import 'package:provider/provider.dart';

class EditGroupObjectiveBody extends StatelessWidget {
  const EditGroupObjectiveBody({super.key});

  @override
  Widget build(BuildContext context) {
    final groupObjectiveController =
        Provider.of<EditGroupObjectiveProvider>(context)
            .groupObjectiveController;
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: kDefaultPadding,
        horizontal: kDefaultPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
            width: 400,
            child: TextFieldModel(
              controller: groupObjectiveController,
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
          const SizedBox(height: Insets.l),
          const StaticText(text: 'Change group objective', fontSize: TextSize.mBody),
        ],
      ),
    );
  }
}
