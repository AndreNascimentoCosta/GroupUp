import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/screens/home/screens/home.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppBarOnboarding extends StatelessWidget with PreferredSizeWidget {
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
                child: const StaticText(
                  text: 'GroupUp',
                  fontSize: TextSize.subTitle,
                  fontFamily: 'Montserrat-SemiBold',
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
                          (route) => false);
                    },
                    child: StaticText(
                      text: appLocalizations.skip,
                      fontSize: TextSize.lBody,
                      fontFamily: 'Montserrat-SemiBold',
                      color: kSecondaryColor,
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
