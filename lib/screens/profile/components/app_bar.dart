import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/bottom_sheet/gp_modal_bottom_sheet.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/utils/icons/gp_icons.dart';
import 'package:groupup/core/widgets/icons/gp_icon.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/core/constants/design-system.dart';
import 'package:groupup/screens/profile/components/other_options.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class AppBarProfile extends StatelessWidget implements PreferredSizeWidget {
  const AppBarProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return AppBar(
      elevation: 0,
      backgroundColor: GPColors.white,
      automaticallyImplyLeading: false,
      title: StaticText(
        text: appLocalizations.profile,
        fontFamily: 'Montserrat-SemiBold',
        fontSize: TextSize.subTitle,
      ),
      centerTitle: false,
      actions: [
        Align(
          alignment: Alignment.center,
          child: ButtonCommonStyle(
              onPressed: () {
                Provider.of<MixPanelProvider>(context, listen: false)
                    .logEvent(eventName: 'Other Options Profile');
                gpModalBottomSheet(
                  context,
                  240,
                  const OtherOptionsProfile(),
                );
              },
              child: const Padding(
                padding: EdgeInsets.only(right: kDefaultPadding),
                child: SizedBox(
                  height: Insets.xl,
                  width: Insets.xl,
                  child: GPIcon(
                    GPIcons.ellipsis,
                    color: GPColors.black,
                  ),
                ),
              )),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kAppBarHeight);
}
