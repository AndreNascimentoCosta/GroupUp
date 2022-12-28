import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/extra_large_body.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/groups/components/dropdown.dart';
import 'package:groupup/models/participant.dart';
import 'package:groupup/screens/individual_group/components/chart/comparative_chart.dart';
import 'package:groupup/screens/individual_group/components/chart/label.dart';
import 'package:groupup/screens/individual_group/components/individual_value.dart';
import 'package:groupup/models/home_view.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/screens/individual_group/components/make_admin.dart';

class IndividualGroupCard extends StatefulWidget {
  const IndividualGroupCard({
    Key? key,
    required this.participant,
    required this.meParticipant,
    required this.homeViewModel,
  }) : super(key: key);

  final Participant participant;
  final Participant meParticipant;
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
          ValueListenableBuilder(
              valueListenable: widget.homeViewModel.isEditing,
              builder: (context, value, child) {
                return ButtonCommonStyle(
                  onPressed: widget.homeViewModel.isEditing.value
                      ? () {
                          showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(Insets.m),
                              ),
                              builder: (context) {
                                return Padding(
                                  padding: MediaQuery.of(context).viewInsets,
                                  child: Wrap(
                                    children: <Widget>[
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.15,
                                            child: MakeAdmin(participant: widget.participant),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              });
                        }
                      : dropDownModel.switchEdit,
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
                              child: SvgPicture.asset(
                                'assets/icons/minus.svg',
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
                        child:
                            ExtraLargeBody(text: widget.participant.rank),
                      ),
                      const SizedBox(width: kDefaultPadding),
                      CircleAvatar(
                          radius: 25,
                          backgroundImage:
                              AssetImage(widget.participant.profilePicture)),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: kDefaultPadding,
                          ),
                          child: StaticText(
                            text: Characters(widget.participant.name)
                                .replaceAll(
                                    Characters(''), Characters('\u{200B}'))
                                .toString(),
                            overflow: TextOverflow.ellipsis,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(width: kDefaultPadding),
                      IndividualValue(
                        homeViewModel: widget.homeViewModel,
                        userInputData: widget.participant.sumData,
                        dropDownModel: dropDownModel,
                      ),
                    ],
                  ),
                );
              }),
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
                        ChartLabel(
                          participant: widget.participant,
                        ),
                        const Spacer(),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: ComparativeChart(
                            userData1: widget.meParticipant.inputData,
                            userData2: widget.participant.inputData,
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
