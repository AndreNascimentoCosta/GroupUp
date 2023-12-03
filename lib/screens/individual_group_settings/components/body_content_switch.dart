import 'package:flutter/material.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/core/widgets/buttons/switch_button.dart';
import 'package:groupup/core/providers/create_group_provider.dart';
import 'package:groupup/core/widgets/texts/gu_text_body.dart';
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
    final screenHeight = context.screenHeight;
    final screenWidth = context.screenWidth;
    final isVerySmallScreen = screenHeight < 600 || screenWidth < 350;
    final createGroupProvider = Provider.of<CreateGroupProvider>(context);
    final group = Provider.of<IndividualGroupProvider>(context).group;
    if (group == null) return const SizedBox();
    return Row(
      children: [
        SizedBox(
          width: isVerySmallScreen ? screenWidth * 0.675 : screenWidth * 0.65,
          child: GUTextBody(
            text: text,
            maxLines: 2,
            minFontSize: 16,
            maxFontSize: 18,
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
