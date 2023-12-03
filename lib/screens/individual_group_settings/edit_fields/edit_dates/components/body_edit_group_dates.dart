import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/constants/design-system.dart';
import 'package:groupup/core/providers/edit_group_dates_provider.dart';
import 'package:groupup/core/widgets/texts/gu_text_body.dart';
import 'package:groupup/screens/individual_group_settings/edit_fields/edit_dates/components/date_time_picker_edit_group_dates.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditGroupDatesBody extends StatelessWidget {
  const EditGroupDatesBody({super.key});

  @override
  Widget build(BuildContext context) {
    final groupDatesProvider = Provider.of<EditGroupDatesProvider>(context);
    final appLocalizations = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: kDefaultPadding,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DateTimePickerEditGroupDates(
              onChanged: (startDate, endDate) {
                groupDatesProvider.newGroup.startDate = startDate;
                groupDatesProvider.newGroup.endDate = endDate;
              },
            ),
            const SizedBox(height: Insets.s),
            Padding(
              padding: const EdgeInsets.only(left: kDefaultPadding),
              child: GUTextBody(text: appLocalizations.changeGroupDates),
            ),
          ],
        ),
      ),
    );
  }
}
