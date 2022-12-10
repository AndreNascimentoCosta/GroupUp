import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/screens/group_settings/components/share_button.dart';
import 'package:groupup/screens/group_settings/models/other_setting_option.dart';
import 'package:groupup/screens/group_settings/models/switch_button.dart';
import 'package:groupup/styles/button_style.dart';
import 'package:groupup/styles/standard_text.dart';

class BodySettings extends StatelessWidget {
  BodySettings({super.key});

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
            children: [
              SizedBox(
                width: 250,
                child: StandardTextStyle(
                  text: 'Everyone can edit group picture',
                  fontSize: 18,
                ),
              ),
              const Spacer(),
              const SwitchButton(),
            ],
          ),
          const SizedBox(
            height: kDefaultPadding * 1.5,
          ),
          Row(
            children: [
              SizedBox(
                width: 250,
                child: StandardTextStyle(
                  text: 'Allow refund request',
                  fontSize: 18,
                ),
              ),
              const Spacer(),
              const SwitchButton(),
            ],
          ),
          const SizedBox(
            height: kDefaultPadding * 1.5,
          ),
          Row(
            children: [
              SizedBox(
                width: 250,
                child: StandardTextStyle(
                  text: 'Number of participants',
                  fontSize: 18,
                ),
              ),
              const Spacer(),
              ButtonCommonStyle(
                child: SizedBox(
                  width: 60,
                  child: StandardTextStyle(
                    text: '10',
                    textAlign: TextAlign.center,
                    fontSize: 18,
                  ),
                ),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(
            height: 300,
          ),
          Row(
            children: [
              SizedBox(
                width: 150,
                child: StandardTextStyle(
                  text: 'Group code',
                  fontSize: 18,
                ),
              ),
              const Spacer(),
              const ShareButton(),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          OtherSettingOption(onPressed: () {}, text: 'Request refund'),
          const SizedBox(
            height: 20,
          ),
          OtherSettingOption(onPressed: () {}, text: 'Exit group'),
          const SizedBox(
            height: 20,
          ),
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
