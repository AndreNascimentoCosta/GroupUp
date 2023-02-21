import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/providers/join_group_provider.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SecondPageJoin extends StatefulWidget {
  const SecondPageJoin({required this.controller});

  final PageController controller;

  @override
  State<SecondPageJoin> createState() => _SecondPageJoinJoinState();
}

class _SecondPageJoinJoinState extends State<SecondPageJoin> {
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
            child: CircularProgressIndicator(color: kPrimaryColor),
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
                          height: MediaQuery.of(context).size.height * 0.04),
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
                              color: kSecondaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.025),
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
                              color: kSecondaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.025),
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
                                  '${NumberFormat.simpleCurrency(name: group[0].data()['groupCurrencyCode']).currencySymbol} ${group[0].data()['reward']}',
                              maxLines: 2,
                              fontSize: TextSize.mBody,
                              color: kSecondaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.025),
                      Row(
                        children: [
                          StaticText(
                            text: '${appLocalizations.noParticipants}:',
                            fontSize: TextSize.mBody,
                          ),
                          const SizedBox(width: kDefaultPadding / 2),
                          Expanded(
                            child: StaticText(
                              text:
                                  group[0].data()['noParticipants'].toString(),
                              maxLines: 2,
                              fontSize: TextSize.mBody,
                              color: kSecondaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.025),
                      Row(
                        children: [
                          StaticText(
                            text: '${appLocalizations.startEndDate}:',
                            fontSize: TextSize.mBody,
                          ),
                          const SizedBox(width: kDefaultPadding / 2),
                          StaticText(
                            text: '${DateFormat.yMd(
                              Localizations.localeOf(context).toLanguageTag(),
                            ).format(
                              group[0].data()['startDate'].toDate() ?? DateTime.now(),
                            )} - ${DateFormat.yMd(
                              Localizations.localeOf(context).toLanguageTag(),
                            ).format(
                              group[0].data()['endDate'].toDate() ?? DateTime.now(),
                            )}',
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
      },
    );
  }
}
