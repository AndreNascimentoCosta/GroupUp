import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/models/dropdown.dart';
import 'package:groupup/models/user_information.dart';
import 'package:groupup/models/home_view.dart';
import 'package:groupup/styles/button.dart';
import 'package:groupup/styles/text.dart';

class IndividualValue extends StatelessWidget {
  const IndividualValue(
      {required this.homeViewModel,
      required this.individualGroup,
      required this.dropDownModel});

  final HomeViewModel homeViewModel;
  final UserInformation individualGroup;
  final DropDownModel dropDownModel;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: homeViewModel.isEditing,
        builder: (context, value, child) {
          return AnimatedContainer(
            width: !value ? 90 : 0,
            duration: const Duration(milliseconds: 50),
            child: Visibility(
              visible: !value,
              child: FittedBox(
                child: Row(
                  children: [
                    StandardTextStyle(
                        text: individualGroup.value, fontSize: 20),
                    const SizedBox(width: kDefaultPadding / 2),
                    ButtonCommonStyle(
                      onPressed: dropDownModel.switchEdit,
                      child: ValueListenableBuilder(
                          valueListenable: dropDownModel.isOpened,
                          builder: ((context, value, child) {
                            return ImageIcon(
                              AssetImage(
                                dropDownModel.isOpened.value
                                    ? 'assets/icons/minus.png'
                                    : 'assets/icons/arrow_down.png',
                              ),
                              size: kDefaultPadding * 2,
                              color: Colors.black,
                            );
                          })),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
