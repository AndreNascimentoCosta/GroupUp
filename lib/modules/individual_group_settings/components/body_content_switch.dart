import 'package:flutter/material.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/core/widgets/buttons/switch_button.dart';
import 'package:groupup/core/providers/create_group_provider.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';
import 'package:provider/provider.dart';

class BodyContentSwitch extends StatelessWidget {
  const BodyContentSwitch({
    required this.text,
    required this.boolValue,
  });

  final String text;
  final bool boolValue;

  @override
  Widget build(BuildContext context) {
    final isVerySmallScreen = context.screenHeight < 600 || context.screenWidth < 350;
    final createGroupProvider = Provider.of<CreateGroupProvider>(context);
    final group = Provider.of<IndividualGroupProvider>(context).group;
    if (group == null) return const SizedBox();
    return Row(
      children: [
        SizedBox(
          width: isVerySmallScreen ? context.screenWidth * 0.675 : context.screenWidth * 0.65,
          child: GPTextBody(
            text: text,
            maxLines: 2,
            fontSize: 16,
          ),
        ),
        const Spacer(),
        SwitchButton(
          onChanged: (value) {
            createGroupProvider.updateAllowEditImage(
              context,
              value,
              group.id,
            );
          },
          boolValue: boolValue,
        ),
      ],
    );
  }
}
