import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/screens/home/components/text_field.dart';

class FirsPageCreate extends StatefulWidget {
  const FirsPageCreate({required this.controller, required this.count});

  final PageController controller;
  final int count;

  @override
  State<FirsPageCreate> createState() => _FirsPageCreateState();
}

class _FirsPageCreateState extends State<FirsPageCreate> {
  final controllerProjectName = TextEditingController();
  final controllerObjective = TextEditingController();
  final controllerReward = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.035),
            TextFieldModelHome(
              controller: controllerProjectName,
              header: 'Project name',
              textInputAction: TextInputAction.next,
              hint: 'Enter project name',
              padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.035),
            TextFieldModelHome(
              controller: controllerObjective,
              header: 'Objective',
              hint: 'Enter objective',
              textInputAction: TextInputAction.next,
              padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.035),
            TextFieldModelHome(
              controller: controllerReward,
              header: 'Reward',
              hint: 'Enter reward',
              padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
