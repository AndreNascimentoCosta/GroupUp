import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/utils/icons/gp_icons.dart';
import 'package:groupup/core/widgets/texts/gu_text_body.dart';
import 'package:groupup/screens/groups/components/dropdown.dart';
import 'package:groupup/models/home_view.dart';
import 'package:groupup/models/user_input_data.dart';

class IndividualValue extends StatelessWidget {
  const IndividualValue(
      {required this.homeViewModel,
      required this.userInputData,
      required this.dropDownModel});

  final HomeViewModel homeViewModel;
  final UserInputData userInputData;
  final DropDownModel dropDownModel;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: homeViewModel.isEditing,
      builder: (context, value, child) {
        return AnimatedContainer(
          width: !value ? 110 : 0,
          duration: const Duration(milliseconds: 10),
          child: Visibility(
            visible: !value,
            child: Row(
              children: [
                const Spacer(),
                SizedBox(
                  width: 65,
                  child: GUTextBody(
                    text: userInputData.value == 0
                        ? userInputData.value.toString()
                        : userInputData.value < 1
                            ? userInputData.value.toStringAsFixed(3)
                            : userInputData.value < 5
                                ? userInputData.value.toStringAsFixed(2)
                                : userInputData.value
                                    .round()
                                    .toStringAsFixed(1),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    minFontSize: 18,
                    maxFontSize: 20,
                  ),
                ),
                const SizedBox(
                  width: kDefaultPadding / 5,
                ),
                ValueListenableBuilder(
                  valueListenable: dropDownModel.isOpened,
                  builder: ((context, value, child) {
                    return ImageIcon(
                      AssetImage(
                        dropDownModel.isOpened.value
                            ? GPIcons.minus
                            : GPIcons.arrowDown,
                      ),
                      size: kDefaultPadding * 2,
                      color: GPColors.black,
                    );
                  }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
