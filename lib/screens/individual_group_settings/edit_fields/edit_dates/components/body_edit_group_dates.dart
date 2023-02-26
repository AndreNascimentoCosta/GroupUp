import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/home/components/bottom_sheet/create_group/components/date_time_picker.dart';
import 'package:groupup/core/providers/edit_group_dates_provider.dart';
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
            DateTimePicker(
              onChanged: (startDate, endDate) {
                groupDatesProvider.newGroup.startDate = startDate?.toUtc();
                groupDatesProvider.newGroup.endDate = endDate?.toUtc();
              },
            ),
            const SizedBox(height: Insets.s),
            Padding(
              padding: const EdgeInsets.only(left: kDefaultPadding),
              child: StaticText(
                text: appLocalizations.changeGroupDates,
                fontSize: TextSize.mBody,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
