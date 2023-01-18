import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/header.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/edit_profile/screens/edit_profile.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:provider/provider.dart';

import '../edit_name_provider.dart';

class AppBarEditName extends StatelessWidget with PreferredSizeWidget {
  const AppBarEditName({super.key});

  @override
  Widget build(BuildContext context) {
    final nameProvider = Provider.of<EditNameProvider>(context);
    return SafeArea(
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.centerStart,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
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
                child: const Header(text: 'Name'),
              ),
              Padding(
                padding: const EdgeInsets.only(left: kDefaultPadding),
                child: ButtonCommonStyle(
                  child: SvgPicture.asset(
                    'assets/icons/arrow_left.svg',
                    height: Insets.l * 1.25,
                    width: Insets.l * 1.25,
                    color: nameProvider.back(context) == null
                        ? kSecondaryColor
                        : Colors.black,
                  ),
                  onPressed: () {
                    nameProvider.confirmDiscard(context);
                  },
                ),
              ),
              Positioned(
                right: kDefaultPadding,
                child: Padding(
                  padding: const EdgeInsets.only(left: kDefaultPadding),
                  child: ButtonCommonStyle(
                    onPressed: nameProvider.done(context),
                    child: StaticText(
                      text: 'Done',
                      fontSize: TextSize.lBody,
                      fontFamily: 'Montserrat-SemiBold',
                      color: nameProvider.done(context) == null
                          ? kSecondaryColor
                          : Colors.black,
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
