import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';

class HomeButton extends StatelessWidget {
  const HomeButton({required this.isGreen});

  final bool isGreen;

  @override
  Widget build(BuildContext context) {
    final screenHeight = context.screenHeight;
    final screenWidth = context.screenWidth;
    final isSmallScreen = screenHeight < 800 || screenWidth < 350;
    return Container(
      padding: EdgeInsets.only(
        right: isGreen ? kDefaultPadding * 1.25 : kDefaultPadding * 0.75,
        left: kDefaultPadding,
      ),
      height: isSmallScreen ? screenHeight * 0.125 : screenHeight * 0.105,
      decoration: BoxDecoration(
        color: isGreen ? const Color(0xFFEBEBEB) : const Color(0xFF46E297),
        borderRadius: BorderRadius.circular(20),
      ),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Text(
            isGreen ? AppLocalizations.of(context).joinAGroup : AppLocalizations.of(context).createNewGroup,
            style: TextStyle(
              fontFamily: 'Montserrat-SemiBold',
              fontSize: 20,
              color: isGreen ? GPColors.black : GPColors.white,
            ),
          ),
          const Spacer(),
          SvgPicture.asset(
            isGreen
                ? 'assets/icons/arrow_right.svg'
                : 'assets/icons/plus.svg',
            height: isGreen ? 26.0 : 32.67,
            width: isGreen ? 15.0 : 32.67,
          ),
        ],
      ),
    );
  }
}
