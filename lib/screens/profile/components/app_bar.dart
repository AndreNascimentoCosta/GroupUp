import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/profile/components/other_options.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class AppBarProfile extends StatelessWidget with PreferredSizeWidget {
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
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Insets.m),
                  ),
                  builder: (context) {
                    return Padding(
                      padding: context.screenViewInsets,
                      child: Wrap(
                        children: <Widget>[
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              SizedBox(
                                height: 240,
                                child: OtherOptionsProfile(),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(right: kDefaultPadding),
                child: SizedBox(
                  height: Insets.xl,
                  width: Insets.xl,
                  child: SvgPicture.asset(
                    'assets/icons/ellipsis.svg',
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
