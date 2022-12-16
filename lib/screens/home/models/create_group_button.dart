import 'package:flutter/material.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/home/components/bottom_sheet/create/home_button.dart';
import 'package:groupup/screens/home/components/bottom_sheet/create/create_page_view.dart';
import 'package:groupup/styles/button.dart';

class CreateGroupButton extends StatelessWidget {
  const CreateGroupButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ButtonCommonStyle(
      onPressed: () {
        showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Insets.m),
            ),
            builder: (context) {
              return Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Wrap(
                  children: <Widget>[
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        SizedBox(height: 580, child: CreatePageView()),
                      ],
                    )
                  ],
                ),
              );
            });
      },
      child: const HomeButton(isGreen: false),
    );
  }
}
