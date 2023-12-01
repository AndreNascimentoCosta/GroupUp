import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/providers/join_group_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/core/constants/design-system.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReviewJoinGroup extends StatefulWidget {
  const ReviewJoinGroup({required this.controller});

  final PageController controller;

  @override
  State<ReviewJoinGroup> createState() => _ReviewJoinGroupJoinState();
}

class _ReviewJoinGroupJoinState extends State<ReviewJoinGroup> {
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    final joinGroupProvider = Provider.of<JoinGroupProvider>(context);
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('groups')
          .where(
            'groupCode',
            isEqualTo: joinGroupProvider.controllerGroupCode.text,
          )
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData == false) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        if (snapshot.data!.docs.isEmpty) {
          return Center(
            child: StaticText(
              text: appLocalizations.noCreatedGroups,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          );
        } else {
          final group = snapshot.data!.docs;
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
                      SizedBox(
                          height: context.screenHeight * 0.04),
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
                              text: group[0].data()['projectName'],
                              maxLines: 2,
                              fontSize: TextSize.mBody,
                              color: GPColors.secondaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                          height: context.screenHeight * 0.02),
                      Row(
                        children: [
                          StaticText(
                            text: '${appLocalizations.objective}:',
                            fontSize: TextSize.mBody,
                          ),
                          const SizedBox(width: kDefaultPadding / 2),
                          Expanded(
                            child: StaticText(
                              text: group[0].data()['objective'],
                              maxLines: 2,
                              fontSize: TextSize.mBody,
                              color: GPColors.secondaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                          height: context.screenHeight * 0.02),
                      Row(
                        children: [
                          StaticText(
                            text: '${appLocalizations.reward}:', //groupFee
                            fontSize: TextSize.mBody,
                          ),
                          const SizedBox(width: kDefaultPadding / 2),
                          Expanded(
                            child: StaticText(
                              text:
                                  group[0].data()['reward'], //'${NumberFormat.simpleCurrency(name: group[0].data()['groupCurrencyCode']).currencySymbol} ${group[0].data()['reward']}'
                              maxLines: 2,
                              fontSize: TextSize.mBody,
                              color: GPColors.secondaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                          height: context.screenHeight * 0.02),
                      Row(
                        children: [
                          StaticText(
                            text: '${appLocalizations.numberParticipants}:',
                            fontSize: TextSize.mBody,
                          ),
                          const SizedBox(width: kDefaultPadding / 2),
                          Expanded(
                            child: StaticText(
                              text:
                                  group[0].data()['noParticipants'].toString(),
                              maxLines: 2,
                              fontSize: TextSize.mBody,
                              color: GPColors.secondaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                          height: context.screenHeight * 0.02),
                      Row(
                        children: [
                          StaticText(
                            text: '${appLocalizations.startDate}:',
                            fontSize: TextSize.mBody,
                          ),
                          const SizedBox(width: kDefaultPadding / 2),
                          StaticText(
                            text: DateFormat.yMd(
                              Localizations.localeOf(context).toLanguageTag(),
                            ).format(
                              group[0].data()['startDate'].toDate() ??
                                  DateTime.now(),
                            ),
                            maxLines: 2,
                            fontSize: TextSize.mBody,
                            color: GPColors.secondaryColor,
                          ),
                        ],
                      ),
                      SizedBox(
                          height: context.screenHeight * 0.02),
                      Row(
                        children: [
                          StaticText(
                            text: '${appLocalizations.endDate}:',
                            fontSize: TextSize.mBody,
                          ),
                          const SizedBox(width: kDefaultPadding / 2),
                          StaticText(
                            text: DateFormat.yMd(
                              Localizations.localeOf(context).toLanguageTag(),
                            ).format(
                              group[0].data()['endDate'].toDate() ??
                                  DateTime.now(),
                            ),
                            maxLines: 2,
                            fontSize: TextSize.mBody,
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
      },
    );
  }
}
