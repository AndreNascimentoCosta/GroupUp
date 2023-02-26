import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/widgets/texts/large_body.dart';
import 'package:groupup/core/widgets/texts/medium_body.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/group_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class IndividualCardBalance extends StatelessWidget {
  const IndividualCardBalance({required this.group});

  final GroupModel group;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    final currentUser = Provider.of<AuthProvider>(context).user;
    if (currentUser == null) {
      return const SizedBox();
    }
    final currentUserRank = group.participantsData.firstWhere(
      (element) {
        return element.uid == currentUser.id;
      },
    ).rank(group);
    final participantsSumValue = group.participantsData.map((element) {
      return element.sumData.value;
    }).toList();
    participantsSumValue.sort((a, b) => b.compareTo(a));
    return Row(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                blurRadius: 7,
                color: kSecondaryColor,
                spreadRadius: 0.2,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(37.5),
            child: group.image.isNotEmpty
                ? Image.network(
                    group.image,
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    'assets/icons/profile2.png',
                    height: 50,
                    width: 50,
                  ),
          ),
        ),
        const SizedBox(width: Insets.m),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LargeBody(
              text: group.projectName.replaceAll(RegExp('#'), ''),
              fontFamily: 'Montserrat-SemiBold',
            ),
            const SizedBox(height: Insets.s),
            MediumBody(
              text: group.endDate!.toUtc().isBefore(DateTime.now().toUtc())
                  ? participantsSumValue.length > 1 &&
                          participantsSumValue
                                  .where((element) =>
                                      element == participantsSumValue.first)
                                  .length >
                              1
                      ? group.endDate!.toUtc().isAfter(
                                DateTime.now().toUtc().subtract(
                                      const Duration(
                                        days: 3,
                                      ),
                                    ),
                              )
                          ? appLocalizations.ongoing
                          : appLocalizations.ended
                      : group.endDate!.toUtc().isAfter(
                                DateTime.now().toUtc().subtract(
                                      const Duration(
                                        days: 1,
                                      ),
                                    ),
                              )
                          ? appLocalizations.ongoing
                          : appLocalizations.ended
                  : appLocalizations.ongoing,
              color: kSecondaryColor,
            ),
          ],
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(right: kDefaultPadding),
          child: group.endDate!.toUtc().isBefore(DateTime.now().toUtc())
              ? participantsSumValue.length > 1 &&
                      participantsSumValue
                              .where((element) =>
                                  element == participantsSumValue.first)
                              .length >
                          1
                  ? group.endDate!.toUtc().isAfter(
                            DateTime.now().toUtc().subtract(
                                  const Duration(
                                    days: 3,
                                  ),
                                ),
                          )
                      ? const LargeBody(
                          text: 'R\$ -',
                          color: kSecondaryColor,
                        )
                      : currentUserRank == '1º'
                          ? LargeBody(
                              text:
                                  'R\$${(int.parse(group.reward) * group.participants.length).toStringAsFixed(2)}',
                              color: Colors.green,
                            )
                          : LargeBody(
                              text:
                                  '-R\$ ${int.parse(group.reward).toStringAsFixed(2)}',
                              color: Colors.red,
                            )
                  : group.endDate!.toUtc().isAfter(
                            DateTime.now().toUtc().subtract(
                                  const Duration(
                                    days: 1,
                                  ),
                                ),
                          )
                      ? const LargeBody(
                          text: 'R\$ -',
                          color: kSecondaryColor,
                        )
                      : currentUserRank == '1º'
                          ? LargeBody(
                              text:
                                  'R\$${(int.parse(group.reward) * group.participants.length).toStringAsFixed(2)}',
                              color: Colors.green,
                            )
                          : LargeBody(
                              text:
                                  '-R\$ ${int.parse(group.reward).toStringAsFixed(2)}',
                              color: Colors.red,
                            )
              : const LargeBody(
                  text: 'R\$ -',
                  color: kSecondaryColor,
                ),
        ),
      ],
    );
  }
}
