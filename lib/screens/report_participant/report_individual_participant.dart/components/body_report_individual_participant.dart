import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/providers/report_participant_provider.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/edit_profile/components/text_field.dart';
import 'package:provider/provider.dart';

class BodyReportIndividualParticipant extends StatelessWidget {
  const BodyReportIndividualParticipant({super.key});

  @override
  Widget build(BuildContext context) {
    final reportParticipantController =
        Provider.of<ReportParticipantProvider>(context)
            .reportParticipantController;
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
              height: 50,
              width: 400,
              child: TextFieldModel(
                controller: reportParticipantController,
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
            const StaticText(
              text: 'Describe in a few words the reason of the report',
              fontSize: TextSize.mBody,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
