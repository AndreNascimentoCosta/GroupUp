import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.35,
                          child: const AddBottomSheet(),
                        ),
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
      child: SvgPicture.asset(
        'assets/icons/plus.svg',
        height: Insets.l * 1.5,
        width: Insets.l * 1.5,
      ),
    );
  }
}
