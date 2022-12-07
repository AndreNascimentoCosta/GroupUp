import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';

class ChartLabel extends StatelessWidget {
  const ChartLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: kDefaultPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 10,
                width: 10,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: kPrimaryColor,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                'H. C.',
                style: TextStyle(
                  fontFamily: 'Montserrat-Medium',
                  fontSize: 14,
                  color: kPrimaryColor,
                ),
              ),
            ],
          ),
          Row(
            children: const [
              CircleAvatar(
                backgroundColor: kSecondaryColor,
                radius: 5,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'Me',
                style: TextStyle(
                  fontFamily: 'Montserrat-Medium',
                  fontSize: 14,
                  color: kSecondaryColor,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
