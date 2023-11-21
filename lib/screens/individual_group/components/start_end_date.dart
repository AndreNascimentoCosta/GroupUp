import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/models/group_model.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StartEndDateButton extends StatelessWidget {
  const StartEndDateButton({
    required this.groups,
  });

  final GroupModel groups;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            StaticText(text: '${appLocalizations.start}:'),
            const SizedBox(height: kDefaultPadding / 2),
            StaticText(text: '${appLocalizations.end}:'),
          ],
        ),
        const SizedBox(width: kDefaultPadding / 1.75),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StaticText(
              text: DateFormat.yMd(
                Localizations.localeOf(context).toLanguageTag(),
              ).format(
                groups.startDate ?? DateTime.now(),
              ),
            ),
            const SizedBox(height: kDefaultPadding / 2),
            StaticText(
              text: DateFormat.yMd(
                Localizations.localeOf(context).toLanguageTag(),
              ).format(
                groups.endDate ?? DateTime.now(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
