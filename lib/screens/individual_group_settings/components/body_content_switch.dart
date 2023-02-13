import 'package:flutter/material.dart';
import 'package:groupup/core/widgets/buttons/switch_button.dart';
import 'package:groupup/core/widgets/texts/large_body.dart';
import 'package:groupup/models/group_model.dart';
import 'package:groupup/core/providers/create_group_provider.dart';
import 'package:provider/provider.dart';

class BodyContentSwitch extends StatelessWidget {
  const BodyContentSwitch({
    required this.groups,
    required this.text,
    required this.boolValue,
  });

  final GroupModel groups;
  final String text;
  final bool boolValue;

  @override
  Widget build(BuildContext context) {
    final createGroupProvider = Provider.of<CreateGroupProvider>(context);
    return Row(
      children: [
        SizedBox(
          width: 250,
          child: LargeBody(
            text: text,
            maxLines: 2,
          ),
        ),
        const Spacer(),
        SwitchButton(
          onChanged: (value) {
            createGroupProvider.updateAllowEditImage(value, groups.id);
          },
          boolValue: boolValue,
        ),
      ],
    );
  }
}
