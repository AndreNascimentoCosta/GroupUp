import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/edit_profile/components/text_field.dart';
import 'package:groupup/core/providers/edit_group_objective_provider.dart';
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
              validator: (value) {
                if (value!.isNotEmpty && value.length < 3) {
                  return 'Objective must be at least 3 characters';
                } else if (value.length >= 50) {
                  return 'Objective must be less than 50 characters';
                }
                else {
                  return null;
                }
              },
              maxLength: 50,
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
