import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/widgets/texts/header.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/providers/edit_group_dates_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../core/providers/individual_group_provider.dart';

class AppBarEditGroupDates extends StatelessWidget with PreferredSizeWidget {
  const AppBarEditGroupDates({super.key});

  @override
  Widget build(BuildContext context) {
    final editGroupDatesProvider = Provider.of<EditGroupDatesProvider>(context);
    final appLocalizations = AppLocalizations.of(context);
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
                child: Header(text: appLocalizations.dates),
              ),
              ButtonCommonStyle(
                onPressed: () {
                  if (editGroupDatesProvider.newGroup.startDate == null) {
                    if (editGroupDatesProvider.newGroup.endDate == null) {
                      editGroupDatesProvider.clean();
                      Provider.of<MixPanelProvider>(context, listen: false)
                          .logEvent(
                              eventName:
                                  'Back to Edit Profile Screen from Edit Group Dates Screen');
                      Navigator.of(context).pop();
                    } else {
                      editGroupDatesProvider.confirmDiscard(context);
                    }
                  } else {
                    Provider.of<MixPanelProvider>(context, listen: false).logEvent(
                        eventName:
                            'Discard and Back to Edit Profile Screen from Edit Group Dates Screen');
                    editGroupDatesProvider.confirmDiscard(context);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: kDefaultPadding),
                  child: GestureDetector(
                    child: Container(
                      color: Colors.transparent,
                      width: Insets.l * 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/arrow_left.svg',
                            height: Insets.l * 1.25,
                            width: Insets.l * 1.25,
                            color: Colors.black,
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
                    onPressed: editGroupDatesProvider.done(
                        context, group.startDate, group.endDate, group.id),
                    child: StaticText(
                      text: appLocalizations.done,
                      fontSize: TextSize.lBody,
                      fontFamily: 'Montserrat-SemiBold',
                      color: editGroupDatesProvider.done(context,
                                  group.startDate, group.endDate, group.id) ==
                              null
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
