import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/group.dart';
import 'package:groupup/screens/individual_group_settings/components/exit_group.dart';
import 'package:groupup/screens/individual_group_settings/components/number_participants.dart';
import 'package:groupup/screens/individual_group_settings/components/share_button.dart';
import 'package:groupup/screens/individual_group_settings/models/other_setting_option.dart';
import 'package:groupup/styles/switch_button.dart';
import 'package:groupup/styles/button.dart';
import 'package:groupup/styles/text.dart';
import 'package:share_plus/share_plus.dart';

class BodySettings extends StatelessWidget {
  const BodySettings({required this.groupModel});

  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: kDefaultPadding,
        left: kDefaultPadding,
        right: kDefaultPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: const [
              SizedBox(
                width: 250,
                child: StandardTextStyle(
                    text: 'Everyone can edit group picture', fontSize: 18),
              ),
              Spacer(),
              SwitchButton(),
            ],
          ),
          const SizedBox(height: kDefaultPadding * 1.5),
          Row(
            children: const [
              SizedBox(
                width: 250,
                child: StandardTextStyle(
                    text: 'Allow refund request', fontSize: TextSize.lBody),
              ),
              Spacer(),
              SwitchButton(),
            ],
          ),
          const SizedBox(height: kDefaultPadding * 1.5),
          Row(
            children: [
              const SizedBox(
                width: 250,
                child: StandardTextStyle(
                    text: 'Maximum number of participants',
                    fontSize: TextSize.lBody),
              ),
              const Spacer(),
              ButtonCommonStyle(
                child: SizedBox(
                  width: 60,
                  child: StandardTextStyle(
                      text: (groupModel.userInformation.length + 1).toString(),
                      fontSize: 18,
                      textAlign: TextAlign.center),
                ),
                onPressed: () {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Insets.m),
                      ),
                      builder: (context) {
                        return Padding(
                          padding: MediaQuery.of(context).viewInsets,
                          child: Wrap(
                            children: <Widget>[
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    height: 200,
                                    child: MaxNumberParticipants(
                                      groupModel: groupModel,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      });
                },
              ),
            ],
          ),
          const SizedBox(height: 290),
          Row(
            children: [
              const SizedBox(
                width: 150,
                child: StandardTextStyle(
                    text: 'Group code', fontSize: TextSize.lBody),
              ),
              const Spacer(),
              ShareButton(
                onPressed: () async {
                  await Share.share('846264');
                },
              ),
            ],
          ),
          const SizedBox(height: Insets.l * 4),
          OtherSettingOption(
              onPressed: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Insets.m),
                    ),
                    builder: (context) {
                      return Padding(
                        padding: MediaQuery.of(context).viewInsets,
                        child: Wrap(
                          children: <Widget>[
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                SizedBox(height: 150, child: ExitGroup()),
                              ],
                            )
                          ],
                        ),
                      );
                    });
              },
              text: 'Exit group'),
          const SizedBox(height: Insets.l),
          OtherSettingOption(
              onPressed: () {}, text: 'Delete group', color: Colors.red)
        ],
      ),
    );
  }
}
