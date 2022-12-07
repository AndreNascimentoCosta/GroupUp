import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/models/individual_group.dart';
import 'package:groupup/screens/groups/components/home_view_model.dart';

class IndividualValue extends StatelessWidget {
  const IndividualValue(
      {required this.homeViewModel, required this.individualGroup});

  final HomeViewModel homeViewModel;
  final IndividualGroup individualGroup;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ValueListenableBuilder(
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
                      Text(
                        individualGroup.value,
                        style: const TextStyle(
                          fontSize: kDefaultPadding,
                          fontFamily: 'Montserrat-Medium',
                        ),
                      ),
                      const SizedBox(
                        width: kDefaultPadding / 2,
                      ),
                      const ImageIcon(
                        AssetImage(
                          'assets/icons/arrow_down.png',
                        ),
                        size: kDefaultPadding * 2,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
