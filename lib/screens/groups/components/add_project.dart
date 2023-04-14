import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/groups/components/add_bottom_sheet.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/mix_panel_provider.dart';

class AddProject extends StatelessWidget {
  const AddProject({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Provider.of<MixPanelProvider>(context, listen: false)
            .logEvent(eventName: 'Add Project Button');
        showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Insets.m),
            ),
            builder: (context) {
              return Padding(
                padding: context.screenViewInsets,
                child: Wrap(
                  children: <Widget>[
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: context.screenHeight * 0.35,
                          child: const AddBottomSheet(),
                        ),
                      ],
                    )
                  ],
                ),
              );
            });
      },
      backgroundColor: GPColors.primaryColor,
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
