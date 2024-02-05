import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/providers/join_group_provider.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/utils/icons/gp_icons.dart';
import 'package:groupup/core/widgets/icons/gp_icon.dart';
import 'package:groupup/core/widgets/texts/gp_text_header.dart';
import 'package:groupup/core/widgets/buttons/gp_button.dart';
import 'package:groupup/core/widgets/buttons/button_common_style.dart';
import 'package:groupup/modules/join_group/components/join_group_events.dart';
import 'package:groupup/modules/join_group/pages/join_group_first_page.dart';
import 'package:groupup/modules/join_group/pages/join_group_review_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class JoinGroupPageView extends StatefulWidget {
  const JoinGroupPageView({super.key});

  @override
  State<JoinGroupPageView> createState() => _JoinGroupPageViewState();
}

class _JoinGroupPageViewState extends State<JoinGroupPageView> {
  @override
  Widget build(BuildContext context) {
    final joinGroupProvider = Provider.of<JoinGroupProvider>(context);
    final userId = Provider.of<AuthProvider>(context).user?.id ?? '';
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: kDefaultPadding * 2),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: kDefaultPadding),
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: joinGroupProvider.pageIndex != 0
                        ? ButtonCommonStyle(
                            onPressed: () {
                              Provider.of<MixPanelProvider>(context,
                                      listen: false)
                                  .logEvent(
                                eventName: JoinGroupEvents
                                    .pressBackButtonJoinGroup.value,
                              );
                              joinGroupProvider.controller.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.ease,
                              );
                            },
                            child: const GPIcon(
                              GPIcons.arrowLeft,
                              color: GPColors.secondaryColor,
                            ),
                          )
                        : null,
                  ),
                ),
                GPTextHeader(
                  text: AppLocalizations.of(context)!.joinAGroup,
                  fontSize: 28,
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: joinGroupProvider.controller,
              onPageChanged: joinGroupProvider.updateIndex,
              children: [
                JoinGroupFirstPage(controller: joinGroupProvider.controller),
                JoinGroupReviewPage(controller: joinGroupProvider.controller),
              ],
            ),
          ),
          const SizedBox(height: kDefaultPadding / 2),
          GPButton(
            onPressed: joinGroupProvider.nextButtonJoin(
              context,
              userId,
            ),
          ),
          const SizedBox(height: kDefaultPadding / 4)
        ],
      ),
    );
  }
}
