import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/home/models/dropdown.dart';
import 'package:groupup/screens/home/models/text_field.dart';

class FirsPageJoin extends StatefulWidget {
  const FirsPageJoin({required this.controller, required this.count});

  final PageController controller;
  final int count;

  @override
  State<FirsPageJoin> createState() => _FirsPageJoinState();
}

class _FirsPageJoinState extends State<FirsPageJoin> {
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
            const SizedBox(height: Insets.l * 1.5),
            const TextFieldModelHome(
              header: 'Project name',
              hint: 'Enter project name',
              padding: EdgeInsets.symmetric(
                horizontal: kDefaultPadding,
              ),
            ),
            const SizedBox(height: Insets.l * 1.5),
            const TextFieldModelHome(
              header: 'Objective',
              hint: 'Enter objective',
              padding: EdgeInsets.symmetric(
                horizontal: kDefaultPadding,
              ),
            ),
            const SizedBox(height: Insets.l * 1.5),
            Row(
              children: const [
                SizedBox(
                    width: 250,
                    child: TextFieldModelHome(
                      header: 'Reward',
                      hint: 'Enter reward',
                      padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding,
                      ),
                    )),
                DropDown(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
