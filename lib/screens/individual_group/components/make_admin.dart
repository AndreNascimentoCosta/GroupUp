import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/widgets/texts/large_body.dart';
import 'package:groupup/core/widgets/texts/medium_body.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/participant.dart';

class MakeAdmin extends StatelessWidget {
  const MakeAdmin({required this.participant});

  final Participant participant;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: Insets.s),
        MediumBody(text: participant.name, color: kSecondaryColor),
        const Divider(height: Insets.l, color: kSecondaryColor, thickness: 0.5),
        const SizedBox(height: Insets.s),
        Align(
          alignment: Alignment.center,
          child: ButtonCommonStyle(
            onPressed: () {},
            child: const LargeBody(
              text: 'Make group admin',
            ),
          ),
        ),
      ],
    );
  }
}
