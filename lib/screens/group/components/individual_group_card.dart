import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/models/dropdown.dart';
import 'package:groupup/models/user_information.dart';
import 'package:groupup/screens/group/components/chart/comparative_chart.dart';
import 'package:groupup/screens/group/components/chart/label.dart';
import 'package:groupup/screens/group/components/individual_value.dart';
import 'package:groupup/models/home_view.dart';
import 'package:groupup/styles/button.dart';
import 'package:groupup/styles/ellipsis_text.dart';
import 'package:groupup/styles/text.dart';

class IndividualGroupCard extends StatefulWidget {
  const IndividualGroupCard({
    Key? key,
    required this.individualGroup,
    required this.meIndividualGroup,
    required this.homeViewModel,
  }) : super(key: key);

  final UserInformation individualGroup;
  final UserInformation meIndividualGroup;
  final HomeViewModel homeViewModel;

  @override
  State<IndividualGroupCard> createState() => _IndividualGroupCardState();
}

class _IndividualGroupCardState extends State<IndividualGroupCard> {
  bool isChecked = false;
  final DropDownModel dropDownModel = DropDownModel();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Column(
        children: [
          ButtonCommonStyle(
            onPressed: dropDownModel.switchEdit,
            child: Row(
              children: [
                ValueListenableBuilder(
                  valueListenable: widget.homeViewModel.isEditing,
                  builder: (context, value, child) {
                    return AnimatedContainer(
                      width: value ? 50 : 0,
                      duration: const Duration(milliseconds: 50),
                      child: Visibility(
                        visible: value,
                        child: const ImageIcon(
                          AssetImage(
                            'assets/icons/remove_participant.png',
                          ),
                          color: Colors.red,
                        ),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: kDefaultPadding / 2,
                  ),
                  child: StandardTextStyle(
                      text: widget.individualGroup.rank, fontSize: 20),
                ),
                const SizedBox(width: kDefaultPadding),
                CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage(widget.individualGroup.image)),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: kDefaultPadding,
                    ),
                    child: StandardEllipsisTextStyle(
                      text: widget.individualGroup.name,
                      overflow: TextOverflow.ellipsis,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(width: kDefaultPadding),
                IndividualValue(
                  homeViewModel: widget.homeViewModel,
                  individualGroup: widget.individualGroup,
                  dropDownModel: dropDownModel,
                ),
              ],
            ),
          ),
          ValueListenableBuilder(
            valueListenable: dropDownModel.isOpened,
            builder: (context, value, child) {
              return AnimatedContainer(
                height: value ? kDefaultPadding : 0,
                duration: const Duration(milliseconds: 150),
                child: Visibility(
                  visible: value,
                  child: const SizedBox(
                    height: kDefaultPadding,
                  ),
                ),
              );
            },
          ),
          ValueListenableBuilder(
              valueListenable: dropDownModel.isOpened,
              builder: (context, value, child) {
                return AnimatedContainer(
                  height: value ? 100 : 0,
                  duration: const Duration(milliseconds: 70),
                  child: Visibility(
                    visible: value,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: kDefaultPadding,
                        ),
                        const ChartLabel(),
                        const Spacer(),
                        SizedBox(
                          width: 250,
                          child: ComparativeChart(
                            userData1: widget.meIndividualGroup.userInputData,
                            userData2: widget.individualGroup.userInputData,
                          ),
                        ),
                        const SizedBox(
                          width: kDefaultPadding,
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
