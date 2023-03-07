import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/providers/edit_group_no_participants.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/core/widgets/texts/header.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/models/group_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../core/providers/mix_panel_provider.dart';

class AppBarEditGroupNoParticipats extends StatelessWidget
    with PreferredSizeWidget {
  const AppBarEditGroupNoParticipats({super.key});

  @override
  Widget build(BuildContext context) {
    final editGroupMaxParticipantsProvider =
        Provider.of<EditGroupNoParticipantsProvider>(context);
    final group = Provider.of<IndividualGroupProvider>(context).group;
    if (group == null) {
      return const SizedBox();
    }
    final appLocalizations = AppLocalizations.of(context);
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
                child: Header(text: appLocalizations.participants),
              ),
              ButtonCommonStyle(
                onPressed: () {
                  if (editGroupMaxParticipantsProvider
                          .groupMaxParticipantsController.text ==
                      group.maxParticipants.toString()) {
                    Provider.of<MixPanelProvider>(context, listen: false).logEvent(
                        eventName:
                            'Back to Edit Profile Screen from Edit Group No Participants Screen');
                    Navigator.pop(context);
                  } else {
                    Provider.of<MixPanelProvider>(context, listen: false).logEvent(
                        eventName:
                            'Discard Changes from Edit Group No Participants Screen');
                    editGroupMaxParticipantsProvider.confirmDiscard(context);
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
                    onPressed: editGroupMaxParticipantsProvider.done(
                      context,
                      group.maxParticipants.toString(),
                      group.id,
                      group.participants.length,
                    ),
                    child: StaticText(
                      text: appLocalizations.done,
                      fontSize: TextSize.lBody,
                      fontFamily: 'Montserrat-SemiBold',
                      color: editGroupMaxParticipantsProvider.done(
                                context,
                                group.maxParticipants.toString(),
                                group.id,
                                group.participants.length,
                              ) ==
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
