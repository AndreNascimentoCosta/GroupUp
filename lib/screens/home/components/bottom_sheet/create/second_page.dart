import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/switch.dart';
import 'package:groupup/screens/home/components/bottom_sheet/create/body_switch.dart';
import 'package:groupup/screens/home/components/bottom_sheet/create/date_time.dart';
import 'package:groupup/screens/home/components/bottom_sheet/create/profile_picture_add.dart';
import 'package:groupup/styles/switch_button.dart';
import 'package:groupup/screens/home/models/date_switch.dart';
import 'package:groupup/screens/home/models/text_field.dart';

class SecondPageJoin extends StatefulWidget {
  const SecondPageJoin({
    required this.controller,
    required this.count,
  });

  final PageController controller;
  final int count;

  @override
  State<SecondPageJoin> createState() => _SecondPageJoinState();
}

class _SecondPageJoinState extends State<SecondPageJoin> {
  final SwitchModel switchModel = SwitchModel();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: Insets.l),
            const ProfilePictureAdd(),
            const SizedBox(height: Insets.s),
            Stack(
              alignment: AlignmentDirectional.center,
              children: const [
                Padding(
                  padding:
                      EdgeInsets.only(top: kDefaultPadding * 1.25, left: 240),
                  child: Tooltip(
                      preferBelow: false,
                      showDuration: Duration(seconds: 3),
                      triggerMode: TooltipTriggerMode.tap,
                      message: 'Maximum of 50 participants.',
                      child: Icon(
                        Icons.info,
                        color: kSecondaryColor,
                        size: 30,
                      )),
                ),
                TextFieldModelHome(
                  header: 'Number of participants',
                  hint: 'Enter a number',
                  padding: EdgeInsets.only(
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
    );
  }
}
