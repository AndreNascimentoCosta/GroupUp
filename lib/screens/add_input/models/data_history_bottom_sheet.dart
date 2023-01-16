import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/large_body.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/user_input_data.dart';
import 'package:groupup/screens/add_input/models/single_data.dart';
import 'package:groupup/styles/text.dart';

class DataHistoryBottomSheet extends StatelessWidget {
  const DataHistoryBottomSheet({required this.userInputData});

  final List<UserInputData> userInputData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: Insets.l),
          const StandardTextStyle(
              text: 'Data history',
              textAlign: TextAlign.center,
              fontSize: TextSize.subTitle),
          const SizedBox(height: Insets.l),
          Row(
            children: const [
              SizedBox(
                width: 100,
                child: LargeBody(text: 'Dates'),
              ),
              SizedBox(width: Insets.l),
              Expanded(
                child: LargeBody(
                  text: 'Values',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          const SizedBox(height: Insets.l),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => const Divider(
                height: 20,
                thickness: 0.5,
                color: kSecondaryColor,
              ),
              itemCount: userInputData.length,
              itemBuilder: ((context, index) {
                int itemCount = userInputData.length;
                int reversedIndex = itemCount - 1 - index;
                return SingleData(userInputData: userInputData[reversedIndex]);
              }),
            ),
          )
        ],
      ),
    );
  }
}
