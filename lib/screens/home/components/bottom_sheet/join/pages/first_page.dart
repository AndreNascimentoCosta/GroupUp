import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/screens/home/components/bottom_sheet/create/create_group_provider.dart';
import 'package:groupup/screens/home/components/bottom_sheet/join/join_group_provider.dart';
import 'package:groupup/screens/home/components/text_field.dart';
import 'package:provider/provider.dart';

class FirsPageJoin extends StatefulWidget {
  const FirsPageJoin({required this.controller});

  final PageController controller;

  @override
  State<FirsPageJoin> createState() => _FirsPageJoinState();
}

class _FirsPageJoinState extends State<FirsPageJoin> {
  @override
  Widget build(BuildContext context) {
    final joinGroupProvider = Provider.of<JoinGroupProvider>(context);
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
            controller: joinGroupProvider.controllerGroupCode,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter group code';
              }
              return null;
            },
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
