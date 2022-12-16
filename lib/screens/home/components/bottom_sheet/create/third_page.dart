import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/group_settings/components/share_button.dart';
import 'package:groupup/styles/text.dart';
import 'package:share_plus/share_plus.dart';

class ThirdPageJoin extends StatelessWidget {
  const ThirdPageJoin({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: Insets.xl * 2),
          const ImageIcon(
            AssetImage('assets/icons/completed.png'),
            size: 200,
            color: kPrimaryColor,
          ),
          const StandardTextStyle(
            text: 'Completed',
            fontFamily: 'Montserrat-SemiBold',
            fontSize: 28,
            color: kPrimaryColor,
          ),
          const SizedBox(height: Insets.xl * 2),
          Row(
            children: [
              const SizedBox(
                width: 180,
                child: StandardTextStyle(
                  text: 'Group code',
                  fontSize: TextSize.lBody,
                ),
              ),
              const Spacer(),
              ShareButton(
                onPressed: () async {
                  await Share.share('846264');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
