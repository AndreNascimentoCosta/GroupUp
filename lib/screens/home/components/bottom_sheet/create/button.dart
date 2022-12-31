import 'package:flutter/material.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/home/components/bottom_sheet/create/create_group_provider.dart';
import 'package:groupup/screens/home/components/home_button.dart';
import 'package:groupup/screens/home/components/bottom_sheet/create/page_view.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:provider/provider.dart';

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
              return ChangeNotifierProvider(
                create: (context) => CreateGroupProvider(),
                child: Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: Wrap(
                    children: <Widget>[
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [ 
                          SizedBox(height: MediaQuery.of(context).size.height * 0.7, child: const CreatePageView()),
                        ],
                      )
                    ],
                  ),
                ),
              );
            });
      },
      child: const HomeButton(isGreen: false),
    );
  }
}
