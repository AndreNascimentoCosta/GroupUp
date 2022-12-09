import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/screens/group_settings/components/share_button.dart';
import 'package:groupup/screens/group_settings/components/switch_button.dart';
import 'package:groupup/styles/button_style.dart';
import 'package:groupup/screens/group_settings/styles/text_style.dart';

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
                child: Text(
                  'Everyone can edit group picture',
                  style: textStyleSettings(),
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
                child: Text(
                  'Allow refund request',
                  style: textStyleSettings(),
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
                child: Text(
                  'Number of participants',
                  style: textStyleSettings(),
                ),
              ),
              const Spacer(),
              ButtonCommonStyle(
                child: SizedBox(
                  width: 60,
                  child: Text(
                    '10',
                    textAlign: TextAlign.center,
                    style: textStyleSettings(),
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
                child: Text(
                  'Group code',
                  style: textStyleSettings(),
                ),
              ),
              const Spacer(),
              const ShareButton(),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          ButtonCommonStyle(
            onPressed: (){},
            child: Text(
              'Request refund',
              style: textStyleSettings(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ButtonCommonStyle(
            onPressed: (){},
            child: Text(
              'Exit group',
              style: textStyleSettings(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ButtonCommonStyle(
            onPressed: (){},
            child: const Text(
              'Delete group',
              style: TextStyle(
                fontFamily: 'Montserrat-Medium',
                fontSize: 18,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
