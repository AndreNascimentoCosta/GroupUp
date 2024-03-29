import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/constants/design_system.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';
import 'package:groupup/models/participant_model.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChartLabel extends StatelessWidget {
  const ChartLabel({required this.participant});

  final Participant participant;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;
    final appLocalizations = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.only(
        top: kDefaultPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          participant.uid != user?.id
              ? Flexible(
                  child: Row(
                    children: [
                      Container(
                        height: 10,
                        width: 10,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: GPColors.primaryColor,
                        ),
                      ),
                      const SizedBox(
                        width: Insets.s,
                      ),
                      GPTextBody(
                        text: participant.name.isNotEmpty
                            ? "${participant.name.trim().split(
                                  RegExp(' +'),
                                ).map(
                                  (s) => s[0],
                                ).take(2).join(". ")}."
                            : '',
                        color: GPColors.primaryColor,
                      ),
                    ],
                  ),
                )
              : const SizedBox(),
          Flexible(
            child: Row(
              children: [
                Container(
                  height: 10,
                  width: 10,
                  decoration: participant.uid != user?.id
                      ? BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: GPColors.secondaryColor,
                            width: 1,
                          ),
                        )
                      : const BoxDecoration(
                          shape: BoxShape.circle,
                          color: GPColors.primaryColor,
                        ),
                ),
                const SizedBox(
                  width: Insets.s,
                ),
                GPTextBody(
                  text: appLocalizations.me,
                  color: participant.uid != user?.id
                      ? GPColors.secondaryColor
                      : GPColors.primaryColor,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
