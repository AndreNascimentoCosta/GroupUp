import 'package:flutter/material.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/groups/components/add_bottom_sheet.dart';
import '../../../constants.dart';

class AddProject extends StatelessWidget {
  const AddProject({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
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
                        SizedBox(height: 300, child: AddBottomSheet()),
                      ],
                    )
                  ],
                ),
              );
            });
      },
      backgroundColor: kPrimaryColor,
      highlightElevation: 0,
      elevation: 0,
      child: const ImageIcon(
        AssetImage(
          'assets/icons/plus_home.png',
        ),
        size: 30,
      ),
    );
  }
}
