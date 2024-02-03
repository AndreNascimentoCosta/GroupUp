import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/extensions/gp_navigator_extension.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/utils/icons/gp_icons.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';
import 'package:groupup/core/widgets/texts/gp_text_header.dart';
import 'package:groupup/core/widgets/texts/gp_text_title.dart';
import 'package:groupup/modules/individual_group/components/individual_group_events.dart';
import 'package:groupup/modules/individual_group/components/objective_reward_details.dart';
import 'package:groupup/modules/individual_group/components/individual_group_start_end_date.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IndividualGroupHeader extends StatelessWidget {
  const IndividualGroupHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final group = Provider.of<IndividualGroupProvider>(context).group;
    final appLocalizations = AppLocalizations.of(context)!;
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
                child: GPTextTitle(
                  text: appLocalizations.name,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Row(
              children: [
                SizedBox(width: context.screenWidth * 0.075),
                ButtonCommonStyle(
                  onPressed: () {},
                  child: const ObjectiveRewardDetails(
                    icon: GPIcons.objective,
                    text: '',
                  ),
                ),
                VerticalDivider(
                  width: context.screenWidth * 0.115,
                  thickness: 1,
                  color: GPColors.secondaryColor,
                ),
                const ObjectiveRewardDetails(
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
          ],
        ),
      );
    }
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
              child: GPTextTitle(
                text: group.projectName,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: context.screenWidth * 0.075,
              ),
              Expanded(
                child: ButtonCommonStyle(
                  onPressed: () {
                    Provider.of<MixPanelProvider>(
                      context,
                      listen: false,
                    ).logEvent(
                      eventName:
                          IndividualGroupEvents.pressObjectiveDialog.value,
                    );
                    showCupertinoDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: GPTextHeader(
                            text: appLocalizations.objective,
                            textAlign: TextAlign.center,
                            fontSize: 18,
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
                            child: GPTextBody(
                              text: group.objective,
                              maxLines: 4,
                              textAlign: TextAlign.center,
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
                                    eventName: IndividualGroupEvents
                                        .dismissObjectiveDialog.value,
                                  );
                                  context.pop();
                                },
                                child: GPTextBody(
                                  text: appLocalizations.ok,
                                  color: GPColors.primaryColor,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: ObjectiveRewardDetails(
                    icon: GPIcons.objective,
                    text: group.objective,
                  ),
                ),
              ),
              VerticalDivider(
                width: context.isVerySmallScreen
                    ? context.screenWidth * 0.05
                    : context.isSmallScreen
                        ? context.screenWidth * 0.075
                        : context.screenWidth * 0.11,
                thickness: 1,
                color: GPColors.secondaryColor,
              ),
              Expanded(
                child: ButtonCommonStyle(
                  onPressed: () {
                    Provider.of<MixPanelProvider>(
                      context,
                      listen: false,
                    ).logEvent(
                      eventName: IndividualGroupEvents.pressRewardDialog.value,
                    );
                    showCupertinoDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: GPTextHeader(
                            text: appLocalizations.reward,
                            textAlign: TextAlign.center,
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
                            child: GPTextBody(
                              text: group.reward,
                              maxLines: 4,
                              textAlign: TextAlign.center,
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
                                    eventName: IndividualGroupEvents
                                        .dismissRewardDialog.value,
                                  );
                                  context.pop();
                                },
                                child: GPTextBody(
                                  text: appLocalizations.ok,
                                  color: GPColors.primaryColor,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: ObjectiveRewardDetails(
                    icon: GPIcons.reward,
                    text: group.reward,
                  ),
                ),
              ),
              VerticalDivider(
                width: context.isVerySmallScreen
                    ? context.screenWidth * 0.06
                    : context.isSmallScreen
                        ? context.screenWidth * 0.075
                        : context.screenWidth * 0.11,
                thickness: 1,
                color: GPColors.secondaryColor,
              ),
              IndividualGroupStartEndDate(
                groups: group,
              ),
              const SizedBox(
                width: kDefaultPadding * 1.5,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
