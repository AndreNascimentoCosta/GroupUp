import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/constants/design-system.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/utils/icons/gp_icons.dart';
import 'package:groupup/core/widgets/icons/gp_icon.dart';
import 'package:groupup/core/widgets/texts/gp_text_header.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InstagrammableAppBar extends StatelessWidget implements PreferredSizeWidget {
  const InstagrammableAppBar({
    super.key,
    this.isSharing = false,
  });

  final bool isSharing;

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
                width: isSharing
                    ? context.screenWidth - context.screenWidth * 0.13
                    : context.screenWidth,
                height: 50,
                alignment: AlignmentDirectional.center,
                child: GPTextHeader(text: appLocalizations.groupUp),
              ),
              Positioned(
                right: isSharing ? kDefaultPadding * 2.5 : kDefaultPadding * 2,
                child: const Padding(
                  padding: EdgeInsets.only(left: kDefaultPadding),
                  child: GPIcon(
                    GPIcons.logoCircle,
                    height: Insets.l * 2,
                    width: Insets.l * 2,
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
