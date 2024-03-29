import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/widgets/bottom_sheet/gp_modal_bottom_sheet.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/utils/icons/gp_icons.dart';
import 'package:groupup/core/widgets/icons/gp_icon.dart';
import 'package:groupup/core/constants/design_system.dart';
import 'package:groupup/core/widgets/texts/gp_text_header.dart';
import 'package:groupup/modules/profile/components/profile_events.dart';
import 'package:groupup/modules/profile/components/profile_other_options.dart';
import 'package:groupup/core/widgets/buttons/button_common_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return AppBar(
      elevation: 0,
      backgroundColor: GPColors.white,
      automaticallyImplyLeading: false,
      title: GPTextHeader(
        text: appLocalizations.profile,
        fontSize: 24,
      ),
      centerTitle: false,
      actions: [
        Align(
          alignment: Alignment.center,
          child: ButtonCommonStyle(
              onPressed: () {
                Provider.of<MixPanelProvider>(context, listen: false).logEvent(
                  eventName: ProfileEvents.pressOtherOptionsProfileButton.value,
                );
                gpModalBottomSheet(
                  context,
                  240,
                  const ProfileOtherOptions(),
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
