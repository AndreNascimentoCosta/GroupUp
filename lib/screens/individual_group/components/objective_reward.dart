import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/core/widgets/buttons/button.dart';

class ObjectiveRewardModel extends StatelessWidget {
  const ObjectiveRewardModel({
    required this.icon,
    required this.text,
    required this.builder,
  });

  final String icon;
  final String text;
  final Widget builder;

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
              return builder;
            });
      },
      child: Column(
        children: [
          SvgPicture.asset(
            icon,
            color: Colors.black,
          ),
          const SizedBox(height: kDefaultPadding / 2),
          SizedBox(
            width: 65,
            child: StaticText(
              text: Characters(text)
                  .replaceAll(Characters(''), Characters('\u{200B}'))
                  .toString(),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
