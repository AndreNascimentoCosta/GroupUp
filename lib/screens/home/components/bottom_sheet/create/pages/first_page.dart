import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/screens/home/components/bottom_sheet/create/components/dropdown.dart';
import 'package:groupup/screens/home/components/text_field.dart';

class FirsPageCreate extends StatefulWidget {
  const FirsPageCreate({required this.controller, required this.count});

  final PageController controller;
  final int count;

  @override
  State<FirsPageCreate> createState() => _FirsPageCreateState();
}

class _FirsPageCreateState extends State<FirsPageCreate> {
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
            const TextFieldModelHome(
              header: 'Project name',
              textInputAction: TextInputAction.next,
              hint: 'Enter project name',
              padding: EdgeInsets.symmetric(
                horizontal: kDefaultPadding,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.035),
            const TextFieldModelHome(
              header: 'Objective',
              hint: 'Enter objective',
              textInputAction: TextInputAction.next,
              padding: EdgeInsets.symmetric(
                horizontal: kDefaultPadding,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.035),
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
