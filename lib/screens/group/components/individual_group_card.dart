import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/models/dropdown.dart';
import 'package:groupup/models/individual_group.dart';
import 'package:groupup/screens/group/components/chart/label.dart';
import 'package:groupup/screens/group/components/individual_value.dart';
import 'package:groupup/models/home_view.dart';
import 'package:groupup/styles/standard_text.dart';

class IndividualGroupCard extends StatefulWidget {
  const IndividualGroupCard({
    Key? key,
    required this.individualGroup,
    required this.homeViewModel,
  }) : super(key: key);

  final IndividualGroup individualGroup;
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
          Row(
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
                  text: widget.individualGroup.rank,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                width: kDefaultPadding,
              ),
              CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage(widget.individualGroup.image),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: kDefaultPadding,
                  ),
                  child: StandardTextStyle(
                    text: widget.individualGroup.name,
                    overflow: TextOverflow.ellipsis,
                    fontSize: 20,
                  ),
                ),
              ),
              IndividualValue(
                homeViewModel: widget.homeViewModel,
                individualGroup: widget.individualGroup,
                dropDownModel: dropDownModel,
              ),
            ],
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
                          child: widget.individualGroup.chart,
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
