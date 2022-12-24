import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/large_body.dart';
import 'package:groupup/core/widgets/texts/title.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/balance/components/button.dart';

class HeaderBalance extends StatelessWidget {
  const HeaderBalance({super.key});

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
          const LargeBody(text: 'Total Balance'),
          Row(
            children: [
              const GroupTitle(
                text: '\$14.60',
                fontFamily: 'Montserrat-SemiBold',
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.05),
              const Button(
                text: 'Add',
                buttonColor: kPrimaryColor,
                textColor: Colors.white,
              ),
              const SizedBox(width: Insets.l),
              const Button(
                text: 'Withdraw',
                buttonColor: Color(0XFFE1E1E1),
                textColor: Colors.black,
              ),
              const SizedBox(height: Insets.l * 2.25),
            ],
          ),
        ],
      ),
    );
  }
}
