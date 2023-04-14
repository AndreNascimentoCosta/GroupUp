import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/widgets/texts/extra_large_body.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/groups/components/stats_no_group.dart';
import 'package:groupup/core/providers/create_group_provider.dart';
import 'package:groupup/screens/home/components/bottom_sheet/create_group/create_page_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/providers/mix_panel_provider.dart';

class NoGroup extends StatelessWidget {
  const NoGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: SizedBox(
          height: context.screenHeight * 0.725,
          child: Column(
            children: [
              ButtonCommonStyle(
                onPressed: () {
                  Provider.of<CreateGroupProvider>(context, listen: false)
                      .clean();
                  Provider.of<MixPanelProvider>(context, listen: false)
                      .logEvent(eventName: 'Create Group Bottom Sheet');
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
                              children: [
                                SizedBox(
                                  height:
                                      context.screenHeight * 0.7,
                                  child: const CreatePageView(),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Row(
                  children: [
                    DottedBorder(
                      borderType: BorderType.Circle,
                      color: GPColors.secondaryColor,
                      dashPattern: const [5, 5],
                      child: const SizedBox(
                        height: 70,
                        width: 70,
                        child: ImageIcon(
                          AssetImage('assets/icons/plus_picture.png'),
                          color: GPColors.secondaryColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: kDefaultPadding,
                      ),
                      child: ExtraLargeBody(
                        text: AppLocalizations.of(context).newGroup,
                        color: GPColors.secondaryColor,
                      ),
                    ),
                    const Flexible(child: StatsNoGroup()),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: Insets.xl * 1.5),
                child: StaticText(
                  text: AppLocalizations.of(context).createOrJoinAGroup,
                  color: GPColors.secondaryColor,
                  fontFamily: 'Montserrat-Medium',
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
