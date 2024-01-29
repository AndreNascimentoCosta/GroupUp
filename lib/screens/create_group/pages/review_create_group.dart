import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/providers/create_group_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';
import 'package:groupup/core/widgets/texts/gp_text_header.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReviewCreateGroup extends StatefulWidget {
  const ReviewCreateGroup({required this.controller});

  final PageController controller;

  @override
  State<ReviewCreateGroup> createState() => _ReviewCreateGroupJoinState();
}

class _ReviewCreateGroupJoinState extends State<ReviewCreateGroup> {
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final createGroupProvider = Provider.of<CreateGroupProvider>(context);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: context.screenHeight * 0.04),
                const GPTextHeader(
                  text: 'Review group info',
                ),
                const SizedBox(height: kDefaultPadding),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GPTextBody(
                      text: '${appLocalizations.projectName}:',
                    ),
                    const SizedBox(width: kDefaultPadding / 2),
                    Expanded(
                      child: GPTextBody(
                        text: createGroupProvider.controllerProjectName.text,
                        maxLines: 2,
                        color: GPColors.secondaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: context.screenHeight * 0.025),
                Row(
                  children: [
                    GPTextBody(
                      text: '${appLocalizations.objective}:',
                    ),
                    const SizedBox(width: kDefaultPadding / 2),
                    Expanded(
                      child: GPTextBody(
                        text: createGroupProvider.controllerObjective.text,
                        maxLines: 2,
                        color: GPColors.secondaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: context.screenHeight * 0.025),
                Row(
                  children: [
                    GPTextBody(
                      text: '${appLocalizations.reward}:', //groupFee
                    ),
                    const SizedBox(width: kDefaultPadding / 2),
                    Expanded(
                      child: GPTextBody(
                        text: createGroupProvider.controllerReward
                            .text, //'${NumberFormat.simpleCurrency(name: createGroupProvider.groupCurrencyCode).currencySymbol} ${createGroupProvider.controllerReward.text}'
                        maxLines: 2,
                        color: GPColors.secondaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: context.screenHeight * 0.025),
                Row(
                  children: [
                    GPTextBody(
                      text: '${appLocalizations.numberParticipants}:',
                    ),
                    const SizedBox(width: kDefaultPadding / 2),
                    Expanded(
                      child: GPTextBody(
                        text: createGroupProvider
                            .controllerNumberParticipants.text,
                        maxLines: 2,
                        color: GPColors.secondaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: context.screenHeight * 0.025),
                Row(
                  children: [
                    GPTextBody(
                      text: '${appLocalizations.startDate}:',
                    ),
                    const SizedBox(width: kDefaultPadding / 2),
                    GPTextBody(
                      text: createGroupProvider.controllerStartDate.text,
                      maxLines: 2,
                      color: GPColors.secondaryColor,
                    ),
                  ],
                ),
                SizedBox(height: context.screenHeight * 0.025),
                Row(
                  children: [
                    GPTextBody(
                      text: '${appLocalizations.endDate}:',
                    ),
                    const SizedBox(width: kDefaultPadding / 2),
                    GPTextBody(
                      text: createGroupProvider.controllerEndDate.text,
                      maxLines: 2,
                      color: GPColors.secondaryColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
