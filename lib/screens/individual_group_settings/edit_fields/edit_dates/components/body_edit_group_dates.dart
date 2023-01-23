import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/home/components/bottom_sheet/create/components/date_time_picker.dart';
import 'package:groupup/core/providers/edit_group_dates_provider.dart';
import 'package:provider/provider.dart';

class EditGroupDatesBody extends StatelessWidget {
  const EditGroupDatesBody({super.key});

  @override
  Widget build(BuildContext context) {
    final groupDatesProvider = Provider.of<EditGroupDatesProvider>(context);
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
                groupDatesProvider.newGroup.startDate = startDate;
                groupDatesProvider.newGroup.endDate = endDate;
              },
            ),
            const SizedBox(height: Insets.s),
            const Padding(
              padding: EdgeInsets.only(left: kDefaultPadding),
              child: StaticText(
                  text: 'Change group name', fontSize: TextSize.mBody),
            ),
          ],
        ),
      ),
    );
  }
}
