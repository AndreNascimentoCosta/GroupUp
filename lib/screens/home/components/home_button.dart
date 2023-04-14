import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/utils/icons/gp_icons.dart';
import 'package:groupup/core/widgets/icons/gp_icon.dart';

class HomeButton extends StatelessWidget {
  const HomeButton({required this.isJoinButton});

  final bool isJoinButton;

  @override
  Widget build(BuildContext context) {
    final screenHeight = context.screenHeight;
    final screenWidth = context.screenWidth;
    final isSmallScreen = screenHeight < 800 || screenWidth < 350;
    return Container(
      padding: EdgeInsets.only(
        right: isJoinButton ? kDefaultPadding * 1.25 : kDefaultPadding * 0.75,
        left: kDefaultPadding,
      ),
      height: isSmallScreen ? screenHeight * 0.125 : screenHeight * 0.105,
      decoration: BoxDecoration(
        color: isJoinButton
            ? const Color(0xFFEBEBEB)
            : const Color(
                0xFF46E297,
              ),
        borderRadius: BorderRadius.circular(20),
      ),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Text(
            isJoinButton
                ? AppLocalizations.of(context).joinAGroup
                : AppLocalizations.of(context).createNewGroup,
            style: TextStyle(
              fontFamily: 'Montserrat-SemiBold',
              fontSize: 20,
              color: isJoinButton ? GPColors.black : GPColors.white,
            ),
          ),
          const Spacer(),
          GPIcon(
            isJoinButton ? GPIcons.arrowRight : GPIcons.plus,
            height: isJoinButton ? 26.0 : 32.67,
            width: isJoinButton ? 15.0 : 32.67,
          ),
        ],
      ),
    );
  }
}
