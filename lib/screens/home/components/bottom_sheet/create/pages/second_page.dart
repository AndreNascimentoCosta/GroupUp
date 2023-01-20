import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/switch.dart';
import 'package:groupup/screens/home/components/bottom_sheet/create/components/body_switch.dart';
import 'package:groupup/screens/home/components/bottom_sheet/create/components/date_time_picker.dart';
import 'package:groupup/screens/home/components/bottom_sheet/create/components/group_picture_add.dart';
import 'package:groupup/core/widgets/buttons/switch_button.dart';
import 'package:groupup/screens/home/components/bottom_sheet/create/create_group_provider.dart';
import 'package:groupup/screens/home/components/text_field.dart';
import 'package:provider/provider.dart';

class SecondPageCreate extends StatefulWidget {
  const SecondPageCreate({
    required this.controller,
  });

  final PageController controller;

  @override
  State<SecondPageCreate> createState() => _SecondPageCreateState();
}

class _SecondPageCreateState extends State<SecondPageCreate> {
  final SwitchModel switchModel = SwitchModel();
  @override
  Widget build(BuildContext context) {
    final createGroupProvider = Provider.of<CreateGroupProvider>(context);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }

        Form.of(context)?.validate();
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
                      message: 'Maximum of 50 participants.',
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
                    header: 'Limit of participants',
                    hint: 'Enter a number',
                    validator: (value) {
                      if (value!.isNotEmpty && int.tryParse(value)! > 50) {
                        return 'Number of participants cannot exceed 50';
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
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: StaticText(
                    text: 'Date',
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
                text: 'Everyone can edit group picture',
                switchType: SwitchButton(
                  onChanged: (value) {
                    final createGroupProvider =
                        Provider.of<CreateGroupProvider>(context,
                            listen: false);
                    createGroupProvider.newGroup.allowEditImage = value;
                  },
                ),
              ),
              BodySwitch(
                text: 'Allow refund request',
                switchType: SwitchButton(
                  onChanged: (value) {
                    final createGroupProvider =
                        Provider.of<CreateGroupProvider>(context,
                            listen: false);
                    createGroupProvider.newGroup.allowRefundRequest = value;
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
