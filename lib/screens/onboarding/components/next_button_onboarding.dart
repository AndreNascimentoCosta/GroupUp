import 'package:flutter/material.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:groupup/core/constants/design-system.dart';
import 'package:groupup/modules/home/presenter/views/home_view.dart';

class GPButtonOnboarding extends StatelessWidget {
  const GPButtonOnboarding({
    required this.controller,
    super.key,
  });

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return ButtonCommonStyle(
      onPressed: () {
        if (controller.page == 3) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const Home(),
            ),
            (route) => false,
          );
        } else {
          controller.nextPage(
            duration: const Duration(
              milliseconds: 300,
            ),
            curve: Curves.ease,
          );
        }
      },
      child: SizedBox(
        width: 150,
        child: StaticText(
          text: AppLocalizations.of(context).next,
          fontFamily: 'Montserrat-SemiBold',
          fontSize: TextSize.lBody * 1.1,
          textAlign: TextAlign.center,
          color: GPColors.primaryColor,
        ),
      ),
    );
  }
}
