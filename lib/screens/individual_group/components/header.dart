import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/utils/icons/gp_icons.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/core/widgets/texts/title.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/core/constants/design-system.dart';
import 'package:groupup/screens/individual_group/components/objective_reward.dart';
import 'package:groupup/screens/individual_group/components/start_end_date.dart';
// import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/providers/mix_panel_provider.dart';

class HeaderIndividualGroup extends StatelessWidget {
  const HeaderIndividualGroup({super.key});

  @override
  Widget build(BuildContext context) {
    final group = Provider.of<IndividualGroupProvider>(context).group;
    final appLocalizations = AppLocalizations.of(context);
    final screenHeight = context.screenHeight;
    final screenWidth = context.screenWidth;
    final isSmallScreen = screenHeight < 800 || screenWidth < 350;
    final isVerySmallScreen = screenHeight < 600 || screenWidth < 300;
    if (group == null) {
      return Container(
        color: GPColors.white,
        height: 125,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: kDefaultPadding / 2.5,
                bottom: kDefaultPadding,
              ),
              child: SizedBox(
                width: 300,
                child: GroupTitle(
                  text: appLocalizations.name,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            IntrinsicHeight(
              child: Row(
                children: [
                  SizedBox(width: screenWidth * 0.075),
                  ButtonCommonStyle(
                    onPressed: () {},
                    child: const ObjectiveRewardModel(
                      icon: GPIcons.objective,
                      text: '',
                    ),
                  ),
                  VerticalDivider(
                    width: screenWidth * 0.115,
                    thickness: 1,
                    color: GPColors.secondaryColor,
                  ),
                  const ObjectiveRewardModel(
                    icon: GPIcons.reward,
                    text: '',
                  ),
                  const VerticalDivider(
                    width: kDefaultPadding * 2.25,
                    thickness: 1,
                    color: GPColors.secondaryColor,
                  ),
                  const SizedBox(
                    width: kDefaultPadding * 1.5,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
    // String groupCurrencySymbol =
    //     NumberFormat.simpleCurrency(name: group.groupCurrencyCode)
    //         .currencySymbol;
    return Container(
      color: GPColors.white,
      height: 125,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: kDefaultPadding / 2.5,
              bottom: kDefaultPadding,
            ),
            child: SizedBox(
              width: context.screenWidth * 0.8,
              child: GroupTitle(
                text: group.projectName,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          IntrinsicHeight(
            child: Row(
              children: [
                SizedBox(
                  width: screenWidth * 0.075,
                ),
                ButtonCommonStyle(
                  onPressed: () {
                    Provider.of<MixPanelProvider>(
                      context,
                      listen: false,
                    ).logEvent(
                      eventName: 'Open Objective Dialog',
                    );
                    showCupertinoDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: StaticText(
                            text: appLocalizations.objective,
                            textAlign: TextAlign.center,
                            fontFamily: 'Montserrat-SemiBold',
                            fontSize: TextSize.lBody,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                          content: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: kDefaultPadding,
                            ),
                            child: StaticText(
                              text: group.objective,
                              maxLines: 4,
                              textAlign: TextAlign.center,
                              fontSize: TextSize.mBody,
                            ),
                          ),
                          actionsAlignment: MainAxisAlignment.center,
                          contentPadding: const EdgeInsets.only(
                            top: 20,
                            bottom: 20,
                          ),
                          actions: [
                            SizedBox(
                              width: double.infinity,
                              child: ButtonCommonStyle(
                                onPressed: () {
                                  Provider.of<MixPanelProvider>(
                                    context,
                                    listen: false,
                                  ).logEvent(
                                    eventName: 'Close Objective Dialog',
                                  );
                                  Navigator.pop(
                                    context,
                                  );
                                },
                                child: const StaticText(
                                  text: 'OK',
                                  color: GPColors.primaryColor,
                                  fontSize: TextSize.mBody,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: ObjectiveRewardModel(
                    icon: GPIcons.objective,
                    text: group.objective,
                  ),
                ),
                VerticalDivider(
                  width: isVerySmallScreen
                      ? screenWidth * 0.05
                      : isSmallScreen
                          ? screenWidth * 0.075
                          : screenWidth * 0.11,
                  thickness: 1,
                  color: GPColors.secondaryColor,
                ),
                ButtonCommonStyle(
                  onPressed: () {
                    Provider.of<MixPanelProvider>(
                      context,
                      listen: false,
                    ).logEvent(
                      eventName: 'Open Reward Dialog',
                    );
                    showCupertinoDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: StaticText(
                            text: appLocalizations.reward,
                            textAlign: TextAlign.center,
                            fontFamily: 'Montserrat-SemiBold',
                            fontSize: TextSize.lBody,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                          content: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: kDefaultPadding,
                            ),
                            child: StaticText(
                              text: group
                                  .reward, //'$groupCurrencySymbol ${(double.parse(group.reward) * group.participants.length).toStringAsFixed(2)}'
                              maxLines: 4,
                              textAlign: TextAlign.center,
                              fontSize: TextSize.mBody,
                            ),
                          ),
                          actionsAlignment: MainAxisAlignment.center,
                          contentPadding: const EdgeInsets.only(
                            top: 20,
                            bottom: 20,
                          ),
                          actions: [
                            SizedBox(
                              width: double.infinity,
                              child: ButtonCommonStyle(
                                onPressed: () {
                                  Provider.of<MixPanelProvider>(
                                    context,
                                    listen: false,
                                  ).logEvent(
                                    eventName: 'Close Reward Dialog',
                                  );
                                  Navigator.pop(context);
                                },
                                child: const StaticText(
                                  text: 'OK',
                                  color: GPColors.primaryColor,
                                  fontSize: TextSize.mBody,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: ObjectiveRewardModel(
                    icon: GPIcons.reward,
                    text: group
                        .reward, //'$groupCurrencySymbol ${(double.parse(group.reward) * group.participants.length).toStringAsFixed(2)}'
                  ),
                ),
                VerticalDivider(
                  width: isVerySmallScreen
                      ? screenWidth * 0.06
                      : isSmallScreen
                          ? screenWidth * 0.075
                          : screenWidth * 0.11,
                  thickness: 1,
                  color: GPColors.secondaryColor,
                ),
                StartEndDateButton(
                  groups: group,
                ),
                const SizedBox(
                  width: kDefaultPadding * 1.5,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
