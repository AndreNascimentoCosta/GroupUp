import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/switch.dart';
import 'package:groupup/screens/home/components/bottom_sheet/create/components/body_switch.dart';
import 'package:groupup/screens/home/components/bottom_sheet/create/components/date_time.dart';
import 'package:groupup/screens/home/components/bottom_sheet/create/components/profile_picture_add.dart';
import 'package:groupup/core/widgets/buttons/switch_button.dart';
import 'package:groupup/screens/home/components/bottom_sheet/create/components/date_switch.dart';
import 'package:groupup/screens/home/components/text_field.dart';

class SecondPageCreate extends StatefulWidget {
  const SecondPageCreate({
    required this.controller,
    required this.count,
  });

  final PageController controller;
  final int count;

  @override
  State<SecondPageCreate> createState() => _SecondPageCreateState();
}

class _SecondPageCreateState extends State<SecondPageCreate> {
  final SwitchModel switchModel = SwitchModel();
  final controllerNumberParticipants = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
              const ProfilePictureAdd(),
              const SizedBox(height: Insets.s),
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: kDefaultPadding * 1.25, left: 260),
                    child: Tooltip(
                        preferBelow: false,
                        showDuration: const Duration(seconds: 3),
                        triggerMode: TooltipTriggerMode.tap,
                        message: 'Maximum of 50 participants.',
                        child: Icon(
                          Icons.info,
                          color: kSecondaryColor,
                          size: MediaQuery.of(context).size.height * 0.035,
                        )),
                  ),
                  TextFieldModelHome(
                    controller: controllerNumberParticipants,
                    header: 'Number of participants',
                    hint: 'Enter a number',
                    padding: const EdgeInsets.only(
                      left: kDefaultPadding,
                      right: kDefaultPadding * 5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Insets.xs),
              BodySwitch(
                  text: 'Dates',
                  switchType: DateSwitch(switchModel: switchModel)),
              ValueListenableBuilder(
                  valueListenable: switchModel.isSwitched,
                  builder: ((context, value, child) {
                    return AnimatedContainer(
                        height: value ? 45 : 0,
                        duration: const Duration(milliseconds: 50),
                        child: Visibility(
                          visible: value,
                          child: const DateTimeSwicth(),
                        ));
                  })),
              const BodySwitch(
                  text: 'Everyone can edit group picture',
                  switchType: SwitchButton()),
              const BodySwitch(
                  text: 'Allow refund request', switchType: SwitchButton()),
            ],
          ),
        ),
      ),
    );
  }
}
