import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/utils/icons/gp_icons.dart';
import 'package:groupup/core/widgets/icons/gp_icon.dart';
import 'package:groupup/core/widgets/texts/gp_text_header.dart';
import 'package:groupup/core/constants/design_system.dart';
import 'package:groupup/core/widgets/buttons/button_common_style.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditFieldsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const EditFieldsAppBar({
    required this.headerText,
    required this.onPressedLeftButton,
    required this.onPressedRightButton,
    required this.colorRightButton,
    super.key,
  });

  final String headerText;
  final void Function()? onPressedLeftButton;
  final void Function()? onPressedRightButton;
  final Color colorRightButton;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final group = Provider.of<IndividualGroupProvider>(context).group;
    if (group == null) {
      return const Scaffold();
    }
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
                child: GPTextHeader(text: headerText),
              ),
              ButtonCommonStyle(
                onPressed: onPressedLeftButton,
                child: Padding(
                  padding: const EdgeInsets.only(left: kDefaultPadding),
                  child: GestureDetector(
                    child: Container(
                      color: GPColors.transparent,
                      width: Insets.l * 3,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
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
                    onPressed: onPressedRightButton,
                    child: GPTextHeader(
                      text: appLocalizations.done,
                      fontFamily: 'Montserrat-SemiBold',
                      color: colorRightButton,
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
