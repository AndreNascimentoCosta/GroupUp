import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/providers/create_group_provider.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:intl/intl.dart';
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
    final appLocalizations = AppLocalizations.of(context);
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
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                const StaticText(
                  text: 'Review group info',
                  fontSize: TextSize.lBody,
                  fontFamily: 'Montserrat-SemiBold',
                ),
                const SizedBox(height: kDefaultPadding),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StaticText(
                      text: '${appLocalizations.projectName}:',
                      fontSize: TextSize.mBody,
                    ),
                    const SizedBox(width: kDefaultPadding / 2),
                    Expanded(
                      child: StaticText(
                        text: createGroupProvider.controllerProjectName.text,
                        maxLines: 2,
                        fontSize: TextSize.mBody,
                        color: kSecondaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                Row(
                  children: [
                    StaticText(
                      text: '${appLocalizations.objective}:',
                      fontSize: TextSize.mBody,
                    ),
                    const SizedBox(width: kDefaultPadding / 2),
                    Expanded(
                      child: StaticText(
                        text: createGroupProvider.controllerObjective.text,
                        maxLines: 2,
                        fontSize: TextSize.mBody,
                        color: kSecondaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                Row(
                  children: [
                    StaticText(
                      text: '${appLocalizations.groupFee}:',
                      fontSize: TextSize.mBody,
                    ),
                    const SizedBox(width: kDefaultPadding / 2),
                    Expanded(
                      child: StaticText(
                        text:
                            '${NumberFormat.simpleCurrency(name: createGroupProvider.groupCurrencyCode).currencySymbol} ${createGroupProvider.controllerReward.text}',
                        maxLines: 2,
                        fontSize: TextSize.mBody,
                        color: kSecondaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                Row(
                  children: [
                    StaticText(
                      text: '${appLocalizations.noParticipants}:',
                      fontSize: TextSize.mBody,
                    ),
                    const SizedBox(width: kDefaultPadding / 2),
                    Expanded(
                      child: StaticText(
                        text: createGroupProvider
                            .controllerNumberParticipants.text,
                        maxLines: 2,
                        fontSize: TextSize.mBody,
                        color: kSecondaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                Row(
                  children: [
                    StaticText(
                      text: '${appLocalizations.startEndDate}:',
                      fontSize: TextSize.mBody,
                    ),
                    const SizedBox(width: kDefaultPadding / 2),
                    StaticText(
                      text:
                          '${createGroupProvider.controllerStartDate.text} - ${createGroupProvider.controllerEndDate.text}',
                      maxLines: 2,
                      fontSize: TextSize.mBody,
                      color: kSecondaryColor,
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