import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/constants/design-system.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';
import 'package:groupup/models/switch.dart';
import 'package:groupup/screens/create_group/components/body_switch.dart';
import 'package:groupup/screens/create_group/components/date_time_picker_create_group.dart';
import 'package:groupup/screens/create_group/components/group_picture_add.dart';
import 'package:groupup/core/widgets/buttons/switch_button.dart';
import 'package:groupup/core/providers/create_group_provider.dart';
import 'package:groupup/core/widgets/text_field/gp_text_field.dart';
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
    final scrollController = ScrollController();
    final createGroupProvider = Provider.of<CreateGroupProvider>(context);
    final appLocalizations = AppLocalizations.of(context);
    final screenHeight = context.screenHeight;
    final screenWidth = context.screenWidth;
    final isSmallScreen = screenHeight < 800 || screenWidth < 350;
    final isVerySmallScreen = screenHeight < 600 || screenWidth < 350;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scrollbar(
        controller: scrollController,
        child: SingleChildScrollView(
          controller: scrollController,
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
                    padding: EdgeInsets.only(
                      top: kDefaultPadding * 1.25,
                      left: isVerySmallScreen
                          ? 160
                          : isSmallScreen
                              ? 220
                              : 260,
                    ),
                    child: Tooltip(
                      preferBelow: false,
                      showDuration: const Duration(seconds: 3),
                      triggerMode: TooltipTriggerMode.tap,
                      message: appLocalizations.maxParticipants,
                      child: Icon(
                        Icons.info,
                        color: GPColors.secondaryColor,
                        size: screenHeight * 0.035,
                      ),
                    ),
                  ),
                  GPTextField(
                    controller:
                        createGroupProvider.controllerNumberParticipants,
                    header: appLocalizations.numberParticipants,
                    hint: appLocalizations.enterNumber,
                    validator: (value) {
                      if (value!.isNotEmpty && int.tryParse(value)! > 50) {
                        return appLocalizations
                            .numberParticipantsValidatorMaxParticipants;
                      } else if (int.tryParse(value) == 0) {
                        return appLocalizations
                            .numberParticipantsValidatorMinParticipants;
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
              SizedBox(height: isSmallScreen ? Insets.m : Insets.xl),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: GPTextBody(text: appLocalizations.dates),
                ),
              ),
              const SizedBox(height: Insets.s),
              DateTimePickerCreateGroup(
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
