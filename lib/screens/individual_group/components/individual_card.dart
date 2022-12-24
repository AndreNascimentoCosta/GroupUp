import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/extra_large_body.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/dropdown.dart';
import 'package:groupup/models/user_information.dart';
import 'package:groupup/screens/individual_group/components/chart/comparative_chart.dart';
import 'package:groupup/screens/individual_group/components/chart/label.dart';
import 'package:groupup/screens/individual_group/components/individual_value.dart';
import 'package:groupup/models/home_view.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/screens/individual_group/components/make_admin.dart';

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
                                            child: MakeAdmin(individualGroup: widget.individualGroup),
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
                            ExtraLargeBody(text: widget.individualGroup.rank),
                      ),
                      const SizedBox(width: kDefaultPadding),
                      CircleAvatar(
                          radius: 25,
                          backgroundImage:
                              AssetImage(widget.individualGroup.image)),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: kDefaultPadding,
                          ),
                          child: StaticText(
                            text: Characters(widget.individualGroup.name)
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
                        individualGroup: widget.individualGroup,
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
                          individualGroup: widget.individualGroup,
                        ),
                        const Spacer(),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
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
