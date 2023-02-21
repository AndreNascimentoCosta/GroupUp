import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/switch.dart';
import 'package:groupup/screens/home/components/bottom_sheet/create_group/components/body_switch.dart';
import 'package:groupup/screens/home/components/bottom_sheet/create_group/components/date_time_picker.dart';
import 'package:groupup/screens/home/components/bottom_sheet/create_group/components/group_picture_add.dart';
import 'package:groupup/core/widgets/buttons/switch_button.dart';
import 'package:groupup/core/providers/create_group_provider.dart';
import 'package:groupup/screens/home/components/text_field.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SecondPageCreate extends StatelessWidget {
  SecondPageCreate({
    required this.controller,
  });

  final PageController controller;

  final SwitchModel switchModel = SwitchModel();

  @override
  Widget build(BuildContext context) {
    final createGroupProvider = Provider.of<CreateGroupProvider>(context);
    final appLocalizations = AppLocalizations.of(context);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: Insets.l),
              const GroupPictureAdd(),
              const SizedBox(height: Insets.s),
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: kDefaultPadding * 1.25, left: 260),
                    child: Tooltip(
                      preferBelow: false,
                      showDuration: const Duration(seconds: 3),
                      triggerMode: TooltipTriggerMode.tap,
                      message: appLocalizations.maxParticipants,
                      child: Icon(
                        Icons.info,
                        color: kSecondaryColor,
                        size: MediaQuery.of(context).size.height * 0.035,
                      ),
                    ),
                  ),
                  TextFieldModelHome(
                    controller:
                        createGroupProvider.controllerNumberParticipants,
                    header: appLocalizations.noParticipants,
                    hint: appLocalizations.enterNumber,
                    validator: (value) {
                      if (value!.isNotEmpty && int.tryParse(value)! > 50) {
                        return appLocalizations
                            .noParticipantsValidatorMaxParticipants;
                      } else if (int.tryParse(value) == 0) {
                        return appLocalizations
                            .noParticipantsValidatorMinParticipants;
                      } else {
                        return null;
                      }
                    },
                    padding: const EdgeInsets.only(
                      left: kDefaultPadding,
                      right: kDefaultPadding * 5,
                    ),
                    keyboardType:
                        const TextInputType.numberWithOptions(signed: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ],
              ),
              const SizedBox(height: Insets.xl),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: StaticText(
                    text: appLocalizations.dates,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: Insets.s),
              DateTimePicker(
                onChanged: (startDate, endDate) {
                  final createGroupProvider =
                      Provider.of<CreateGroupProvider>(context, listen: false);
                  createGroupProvider.newGroup.startDate = startDate;
                  createGroupProvider.newGroup.endDate = endDate;
                },
              ),
              BodySwitch(
                text: appLocalizations.everyoneCanEditGroupPic,
                switchType: SwitchButton(
                  onChanged: (value) {
                    final createGroupProvider =
                        Provider.of<CreateGroupProvider>(context,
                            listen: false);
                    createGroupProvider.newGroup.allowEditImage = value;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
