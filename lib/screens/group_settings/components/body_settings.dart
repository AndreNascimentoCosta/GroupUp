import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/group_settings/components/share_button.dart';
import 'package:groupup/screens/group_settings/models/other_setting_option.dart';
import 'package:groupup/styles/switch_button.dart';
import 'package:groupup/styles/button.dart';
import 'package:groupup/styles/text.dart';

class BodySettings extends StatelessWidget {
  const BodySettings({super.key});

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
                    text: 'Number of participants', fontSize: TextSize.lBody),
              ),
              const Spacer(),
              ButtonCommonStyle(
                child: const SizedBox(
                  width: 60,
                  child: StandardTextStyle(
                      text: '10', fontSize: 18, textAlign: TextAlign.center),
                ),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 300),
          Row(
            children: [
              const SizedBox(
                width: 150,
                child: StandardTextStyle(
                    text: 'Group code', fontSize: TextSize.lBody),
              ),
              const Spacer(),
              ShareButton(
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: Insets.xl * 2),
          OtherSettingOption(onPressed: () {}, text: 'Request refund'),
          const SizedBox(height: Insets.l),
          OtherSettingOption(onPressed: () {}, text: 'Exit group'),
          const SizedBox(height: Insets.l),
          OtherSettingOption(
            onPressed: () {},
            text: 'Delete group',
            color: Colors.red,
          )
        ],
      ),
    );
  }
}
