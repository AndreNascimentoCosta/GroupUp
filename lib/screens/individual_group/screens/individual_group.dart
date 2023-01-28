import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/screens/individual_group/components/floating_buttons/add_input_group_button.dart';
import 'package:groupup/screens/individual_group/components/calendar_add_input/calendar.dart';
import 'package:groupup/screens/individual_group/components/floating_buttons/calenda_screen_button.dart';
import 'package:groupup/screens/individual_group/components/floating_buttons/edit_group.dart';
import 'package:groupup/screens/individual_group/components/app_bar.dart';
import 'package:groupup/screens/individual_group/components/body.dart';
import 'package:groupup/screens/individual_group/components/header.dart';
import 'package:groupup/models/home_view.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:provider/provider.dart';

class IndividualGroupScreen extends StatelessWidget {
  const IndividualGroupScreen({
    required this.homeViewModel,
  });

  final HomeViewModel homeViewModel;

  @override
  Widget build(BuildContext context) {
    final individualGroupProvider =
        Provider.of<IndividualGroupProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarIndividualGroup(
        homeViewModel: homeViewModel,
      ),
      resizeToAvoidBottomInset: false,
      body: PageView(
        controller: individualGroupProvider.pageController,
        onPageChanged: (value) {
          individualGroupProvider.updateIndex(value);
        },
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Column(
            children: [
              const HeaderIndividualGroup(),
              const SizedBox(height: kDefaultPadding),
              BodyIndividualGroup(
                homeViewModel: homeViewModel,
              )
            ],
          ),
          Column(
            children: const [
              Calendar(),
            ],
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          EditGroupButton(
            homeViewModel: homeViewModel,
          ),
          const SizedBox(height: kDefaultPadding),
          individualGroupProvider.pageIndex == 0
              ? CalendarScreenButton(
                  homeViewModel: homeViewModel,
                )
              : AddInputGroupButton(homeViewModel: homeViewModel),
        ],
      ),
    );
  }
}
