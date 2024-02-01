import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:groupup/core/widgets/texts/gp_text_header.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        right: kDefaultPadding / 4,
        left: kDefaultPadding / 4,
      ),
      height: 50.0,
      width: 180,
      decoration: BoxDecoration(
        color: const Color(0xFFEBEBEB),
        borderRadius: BorderRadius.circular(kDefaultPadding * 0.25),
      ),
      alignment: Alignment.center,
      child: GPTextHeader(
        text: AppLocalizations.of(context)!.editProfile,
        fontSize: 16,
      ),
    );
  }
}