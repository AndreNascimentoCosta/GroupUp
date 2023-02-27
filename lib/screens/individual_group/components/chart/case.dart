import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:intl/intl.dart';

class CaseChart extends StatelessWidget {
  const CaseChart({required this.days});

  final int days;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Column(
        children: [
          const SizedBox(
            height: kDefaultPadding * 0.25,
          ),
          StaticText(
            text: DateFormat.E(
              Localizations.localeOf(context).toLanguageTag(),
            )
                .format(
                  DateTime.now().subtract(
                        Duration(
                          days: days,
                        ),
                      ),
                )[0]
                .toUpperCase(),
            color: kSecondaryColor,
            fontSize: TextSize.xsBody,
          ),
        ],
      ),
    );
  }
}
