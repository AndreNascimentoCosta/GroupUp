import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';
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
          GPTextBody(
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
            color: GPColors.secondaryColor,
            fontSize: 12,
          ),
        ],
      ),
    );
  }
}
