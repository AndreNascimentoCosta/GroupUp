import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/screens/home/models/text_field.dart';

class FirsPageJoin extends StatefulWidget {
  const FirsPageJoin({required this.controller});

  final PageController controller;

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
      child: const Center(
        child: SingleChildScrollView(
          child: TextFieldModelHome(
            header: 'Group code',
            hint: 'Enter group code',
            padding: EdgeInsets.symmetric(
              horizontal: kDefaultPadding,
            ),
          ),
        ),
      ),
    );
  }
}
