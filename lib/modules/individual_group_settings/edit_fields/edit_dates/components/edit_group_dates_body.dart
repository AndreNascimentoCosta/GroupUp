import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/constants/design_system.dart';
import 'package:groupup/core/providers/edit_group_fields_provider.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';
import 'package:groupup/modules/individual_group_settings/edit_fields/edit_dates/components/edit_group_dates_date_time_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditGroupDatesBody extends StatelessWidget {
  const EditGroupDatesBody({super.key});

  @override
  Widget build(BuildContext context) {
    final groupFieldsProvider = Provider.of<EditGroupFieldsProvider>(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: kDefaultPadding,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EditGroupDatesDateTimePicker(
              onChanged: (startDate, endDate) {
                groupFieldsProvider.newGroup.startDate = startDate;
                groupFieldsProvider.newGroup.endDate = endDate;
              },
            ),
            const SizedBox(height: Insets.s),
            Padding(
              padding: const EdgeInsets.only(left: kDefaultPadding),
              child: GPTextBody(text: appLocalizations.changeGroupDates),
            ),
          ],
        ),
      ),
    );
  }
}
