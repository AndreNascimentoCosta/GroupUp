import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/balance/models/button.dart';
import 'package:groupup/styles/text.dart';

class TopBarBalance extends StatelessWidget {
  const TopBarBalance({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: kDefaultPadding,
          ),
          const StandardTextStyle(
            text: 'Total Balance',
            fontSize: TextSize.lBody,
          ),
          Row(
            children: const [
              StandardTextStyle(
                text: '\$14.60',
                fontFamily: 'Montserrat-SemiBold',
                fontSize: 35,
              ),
              SizedBox(width: Insets.l * 1.75),
              Button(
                text: 'Add',
                buttonColor: kPrimaryColor,
                textColor: Colors.white,
              ),
              SizedBox(width: Insets.l),
              Button(
                text: 'Withdraw',
                buttonColor: Color(0XFFE1E1E1),
                textColor: Colors.black,
              ),
              SizedBox(height: Insets.l * 2.25),
              
            ],
          ),
        ],
      ),
    );
  }
}
