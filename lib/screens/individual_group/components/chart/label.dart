import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/participant.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class ChartLabel extends StatelessWidget {
  const ChartLabel({required this.participant});

  final Participant participant;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;
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
                          color: kPrimaryColor,
                        ),
                      ),
                      const SizedBox(
                        width: Insets.s,
                      ),
                      StaticText(
                        text: participant.name.isNotEmpty
                            ? "${participant.name.trim().split(RegExp(' +')).map((s) => s[0]).take(2).join(". ")}."
                            : '',
                        color: kPrimaryColor,
                        fontSize: TextSize.sBody,
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
                              color: kSecondaryColor,
                              width: 1,
                            ),
                          )
                        : const BoxDecoration(
                            shape: BoxShape.circle,
                            color: kPrimaryColor,
                          )),
                const SizedBox(
                  width: Insets.s,
                ),
                StaticText(
                  text: 'Me',
                  color: participant.uid != user?.id
                      ? kSecondaryColor
                      : kPrimaryColor,
                  fontSize: TextSize.sBody,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
