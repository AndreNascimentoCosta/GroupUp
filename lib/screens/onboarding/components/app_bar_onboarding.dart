import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/widgets/texts/gp_text_header.dart';
import 'package:groupup/modules/home/presenter/views/home_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppBarOnboarding extends StatelessWidget implements PreferredSizeWidget {
  const AppBarOnboarding({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return SafeArea(
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.centerStart,
            children: [
              Container(
                width: context.screenWidth,
                height: 50,
                alignment: AlignmentDirectional.center,
                child: const GPTextHeader(
                  text: 'GroupUp',
                  minFontSize: 28,
                  maxFontSize: 28,
                ),
              ),
              Positioned(
                right: 0,
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: ButtonCommonStyle(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const Home(),
                        ),
                        (route) => false,
                      );
                    },
                    child: GPTextHeader(
                      text: appLocalizations.skip,
                      color: GPColors.secondaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kAppBarHeight);
}
