import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/core/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/home_view.dart';
import 'package:groupup/screens/individual_group/components/calendar_add_input/add_input.dart';
import 'package:groupup/core/providers/add_input_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../constants.dart';

class AddInputGroupButton extends StatefulWidget {
  const AddInputGroupButton({
    required this.homeViewModel,
    this.backgroundColor = kPrimaryColor,
    this.icon = 'assets/icons/plus.svg',
  });

  final HomeViewModel homeViewModel;
  final Color backgroundColor;
  final String icon;

  @override
  State<AddInputGroupButton> createState() => _AddInputGroupButtonState();
}

class _AddInputGroupButtonState extends State<AddInputGroupButton> {
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return SizedBox(
      height: 75,
      width: 75,
      child: FittedBox(
        child: ValueListenableBuilder(
          valueListenable: widget.homeViewModel.isEditing,
          builder: ((context, value, child) {
            return FloatingActionButton(
              heroTag: 'btn3',
              highlightElevation: 0,
              onPressed: () {
                final group =
                    Provider.of<IndividualGroupProvider>(context, listen: false)
                        .group;
                Provider.of<AddInputProvider>(context, listen: false).clean();
                if (group == null) return;
                if (group.maxParticipants > 1 &&
                    group.maxParticipants > group.participants.length) {
                  showCupertinoDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: StaticText(
                          text: appLocalizations.youCantDoThis,
                          textAlign: TextAlign.center,
                          fontFamily: 'Montserrat-SemiBold',
                          fontSize: TextSize.lBody,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        content: StaticText(
                          text:
                              appLocalizations.cantAddDataWhenNotEveryoneHasJoined,
                          maxLines: 5,
                          textAlign: TextAlign.center,
                          fontSize: TextSize.mBody,
                        ),
                        actionsAlignment: MainAxisAlignment.center,
                        contentPadding:
                            const EdgeInsets.only(top: 20, bottom: 20),
                        actions: [
                          ButtonCommonStyle(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const StaticText(
                              text: 'OK',
                              fontSize: TextSize.mBody,
                              color: kPrimaryColor,
                            ),
                          )
                        ],
                      );
                    },
                  );
                } else {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Insets.m),
                    ),
                    builder: (context) {
                      return const BuilderBottomSheet(
                        height: 220,
                        child: AddInput(),
                      );
                    },
                  );
                }
              },
              backgroundColor: widget.backgroundColor,
              elevation: 0,
              child: SvgPicture.asset(
                widget.icon,
                height: Insets.l * 1.5,
                width: Insets.l * 1.5,
              ),
            );
          }),
        ),
      ),
    );
  }
}
