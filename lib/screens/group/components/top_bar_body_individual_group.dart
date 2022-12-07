import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/models/top_bar_individual_group.dart';

class TopBarBodyIndividualGroup extends StatelessWidget {
  const TopBarBodyIndividualGroup({required this.topBarIndividualGroup});

  final TopBarIndividualGroupModel topBarIndividualGroup;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 125,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(
              top: kDefaultPadding / 2.5,
              bottom: kDefaultPadding,
            ),
            child: Text(
              'RunForestRun',
              style: TextStyle(
                fontFamily: 'Montserrat-Bold',
                fontSize: 34,
              ),
            ),
          ),
          IntrinsicHeight(
            child: Row(
              children: [
                const SizedBox(
                  width: kDefaultPadding * 1.5,
                ),
                Column(
                  children: [
                    ImageIcon(
                      AssetImage(
                        topBarIndividualGroup.objectiveIcon,
                      ),
                    ),
                    const SizedBox(
                      height: kDefaultPadding / 2,
                    ),
                    Text(
                      topBarIndividualGroup.objective,
                      style: const TextStyle(
                        fontFamily: 'Montserrat-Medium',
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const VerticalDivider(
                  width: kDefaultPadding * 2.25,
                  thickness: 1,
                  color: kSecondaryColor,
                ),
                Column(
                  children: [
                    ImageIcon(
                      AssetImage(
                        topBarIndividualGroup.rewardIcon,
                      ),
                    ),
                    const SizedBox(
                      height: kDefaultPadding / 2,
                    ),
                    Text(
                      topBarIndividualGroup.reward,
                      style: const TextStyle(
                        fontFamily: 'Montserrat-Medium',
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const VerticalDivider(
                  width: kDefaultPadding * 2.25,
                  thickness: 1,
                  color: kSecondaryColor,
                ),
                Column(
                  children: const [
                    Text(
                      'Start',
                      style: TextStyle(
                        fontFamily: 'Montserrat-Medium',
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(
                      height: kDefaultPadding / 2,
                    ),
                    Text(
                      'End',
                      style: TextStyle(
                        fontFamily: 'Montserrat-Medium',
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: kDefaultPadding / 1.5,
                ),
                Column(
                  children: [
                    Text(
                      topBarIndividualGroup.startDate,
                      style: const TextStyle(
                        fontFamily: 'Montserrat-Medium',
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(
                      height: kDefaultPadding / 2,
                    ),
                    Text(
                      topBarIndividualGroup.endDate,
                      style: const TextStyle(
                        fontFamily: 'Montserrat-Medium',
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: kDefaultPadding * 1.5,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
