import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/utils/icons/gp_icons.dart';
import 'package:groupup/core/widgets/icons/gp_icon.dart';
import 'package:groupup/core/constants/design-system.dart';
import 'package:groupup/core/widgets/texts/gp_text_header.dart';
import 'package:groupup/modules/edit_profile/screens/edit_profile.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../core/providers/mix_panel_provider.dart';

class AppBarSavedCards extends StatelessWidget implements PreferredSizeWidget {
  const AppBarSavedCards({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return SafeArea(
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.centerStart,
            children: [
              Container(
                width: context.screenWidth,
                height: 50,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 0.2,
                      color: Color(0xffa1a1a1),
                    ),
                  ),
                ),
                alignment: AlignmentDirectional.center,
                child: GPTextHeader(
                  text: appLocalizations.savedCards,
                  fontFamily: 'Montserrat-Bold',
                  fontSize: 24,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: kDefaultPadding),
                child: ButtonCommonStyle(
                  onPressed: () {
                    Provider.of<MixPanelProvider>(context, listen: false).logEvent(
                        eventName:
                            'Back to Edit Profile Screen from Saved Cards Screen');
                    Navigator.pop(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditProfileScreen(),
                        settings: const RouteSettings(name: 'Edit_Profile'),
                      ),
                    );
                  },
                  child: GestureDetector(
                    child: Container(
                      color: GPColors.transparent,
                      width: Insets.l * 3,
                      child: const Row(
                        children: [
                          GPIcon(
                            GPIcons.arrowLeft,
                            color: GPColors.black,
                            height: Insets.l * 1.25,
                            width: Insets.l * 1.25,
                          ),
                        ],
                      ),
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
  Size get preferredSize => const Size.fromHeight(80);
}
