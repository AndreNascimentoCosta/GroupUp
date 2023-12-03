import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/widgets/texts/gu_text_body.dart';
import 'package:groupup/core/constants/design-system.dart';
import 'package:groupup/models/user_input_data.dart';
import 'package:groupup/screens/individual_group/components/calendar_add_input/single_data.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DataHistoryBottomSheet extends StatelessWidget {
  const DataHistoryBottomSheet({required this.userInputData});

  final List<UserInputData> userInputData;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: Insets.l),
          GUTextBody(
            text: appLocalizations.dataHistory,
            textAlign: TextAlign.center,
            minFontSize: 24,
            maxFontSize: 24,
          ),
          const SizedBox(height: Insets.l),
          Row(
            children: [
              SizedBox(
                width: 100,
                child: GUTextBody(
                  text: appLocalizations.dates,
                  minFontSize: 16,
                  maxFontSize: 18,
                ),
              ),
              const SizedBox(width: Insets.l),
              Expanded(
                child: GUTextBody(
                  text: appLocalizations.values,
                  textAlign: TextAlign.center,
                  minFontSize: 16,
                  maxFontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: Insets.l),
          if (userInputData.isEmpty)
            GUTextBody(
              text: appLocalizations.noData,
              textAlign: TextAlign.center,
              color: GPColors.secondaryColor,
              minFontSize: 16,
              maxFontSize: 18,
            ),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => const Divider(
                height: 20,
                thickness: 0.5,
                color: GPColors.secondaryColor,
              ),
              itemCount: userInputData.length,
              itemBuilder: ((context, index) {
                int itemCount = userInputData.length;
                int reversedIndex = itemCount - 1 - index;
                return SingleData(
                  userInputData: userInputData[reversedIndex],
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}
