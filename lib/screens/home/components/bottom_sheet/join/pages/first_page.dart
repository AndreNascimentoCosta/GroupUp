import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/screens/home/components/text_field.dart';

class FirsPageJoin extends StatefulWidget {
  const FirsPageJoin({required this.controller});

  final PageController controller;

  @override
  State<FirsPageJoin> createState() => _FirsPageJoinState();
}

class _FirsPageJoinState extends State<FirsPageJoin> {
  final controllerGroupCode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Center(
        child: SingleChildScrollView(
          child: TextFieldModelHome(
            controller: controllerGroupCode,
            header: 'Group code',
            hint: 'Enter group code',
            padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding,
            ),
          ),
        ),
      ),
    );
  }
}
