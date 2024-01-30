import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/providers/edit_group_no_participants.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/constants/design-system.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';
import 'package:groupup/screens/edit_profile/components/text_field.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditGroupNoParticipantsBody extends StatelessWidget {
  const EditGroupNoParticipantsBody({super.key});

  @override
  Widget build(BuildContext context) {
    final groupMaxParticipantsController =
        Provider.of<EditGroupNoParticipantsProvider>(context)
            .groupMaxParticipantsController;
    final group = Provider.of<IndividualGroupProvider>(context).group;
    final appLocalizations = AppLocalizations.of(context)!;
    if (group == null) {
      return const SizedBox();
    }
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
            child: TextFieldModel(
              controller: groupMaxParticipantsController,
              hint: '',
              validator: (value) {
                if (value!.isNotEmpty && int.tryParse(value)! > 50) {
                  return appLocalizations
                      .numberParticipantsValidatorMaxParticipants;
                } else if ((int.tryParse(value) ?? 0) <
                    group.participants.length) {
                  return appLocalizations
                      .numberParticipantsValidatorMinParticipantsAfterGroupCreated(
                    group.participants.length,
                  );
                } else {
                  return null;
                }
              },
              keyboardType: const TextInputType.numberWithOptions(signed: true),
              maxLength: 30,
              border: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: GPColors.secondaryColor,
                  width: 0.5,
                ),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
          ),
          const SizedBox(height: Insets.l),
          GPTextBody(
            text: appLocalizations.changeNumberParticipants,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}
