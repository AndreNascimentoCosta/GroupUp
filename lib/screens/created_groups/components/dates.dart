import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/widgets/texts/gu_text_body.dart';
import 'package:groupup/models/group_model.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShowDates extends StatelessWidget {
  const ShowDates({
    required this.group,
  });

  final GroupModel group;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GUTextBody(text: appLocalizations.start),
            const SizedBox(height: kDefaultPadding / 2),
            GUTextBody(text: appLocalizations.end),
          ],
        ),
        const SizedBox(width: kDefaultPadding / 1.75),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GUTextBody(
              text: DateFormat.yMd(
                Localizations.localeOf(context).toLanguageTag(),
              ).format(
                group.startDate ?? DateTime.now(),
              ),
            ),
            const SizedBox(height: kDefaultPadding / 2),
            GUTextBody(
              text: DateFormat.yMd(
                Localizations.localeOf(context).toLanguageTag(),
              ).format(
                group.endDate ?? DateTime.now(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
