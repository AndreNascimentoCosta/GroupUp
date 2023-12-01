import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/utils/icons/gp_icons.dart';
import 'package:groupup/core/widgets/icons/gp_icon.dart';
import 'package:groupup/core/widgets/texts/gu_text_header.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/core/constants/design-system.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../core/providers/edit_profile_name_provider.dart';
import '../../../../../core/providers/mix_panel_provider.dart';

class AppBarEditProfileName extends StatelessWidget implements PreferredSizeWidget {
  const AppBarEditProfileName({super.key});

  @override
  Widget build(BuildContext context) {
    final nameProvider = Provider.of<EditProfileNameProvider>(context);
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
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 0.2,
                      color: Color(0xffa1a1a1),
                    ),
                  ),
                ),
                alignment: AlignmentDirectional.center,
                child: GUTextHeader(text: appLocalizations.name),
              ),
              Padding(
                padding: const EdgeInsets.only(left: kDefaultPadding),
                child: ButtonCommonStyle(
                  onPressed: () {
                    final user =
                        Provider.of<AuthProvider>(context, listen: false).user;
                    if (nameProvider.profileNameController.text == user?.name) {
                      Provider.of<MixPanelProvider>(context, listen: false)
                          .logEvent(eventName: 'Back Button Edit Name');
                      Navigator.pop(context);
                    } else {
                      Provider.of<MixPanelProvider>(context, listen: false)
                          .logEvent(eventName: 'Discard Edit Name');
                      nameProvider.confirmDiscard(context);
                    }
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
              Positioned(
                right: kDefaultPadding,
                child: Padding(
                  padding: const EdgeInsets.only(left: kDefaultPadding),
                  child: ButtonCommonStyle(
                    onPressed: nameProvider.done(context),
                    child: StaticText(
                      text: appLocalizations.done,
                      fontSize: TextSize.lBody,
                      fontFamily: 'Montserrat-SemiBold',
                      color: nameProvider.done(context) == null
                          ? GPColors.secondaryColor
                          : GPColors.black,
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
