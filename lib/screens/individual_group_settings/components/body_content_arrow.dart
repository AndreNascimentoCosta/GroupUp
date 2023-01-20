import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';

class BodyContentArrow extends StatelessWidget {
  const BodyContentArrow({required this.name, this.maxLine = 1});

  final String name;
  final int maxLine;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 250,
          child: StaticText(
            text: name,
            maxLines: maxLine,
            fontSize: TextSize.lBody,
          ),
        ),
        const Spacer(),
        SizedBox(
          width: 60,
          child: SvgPicture.asset(
            'assets/icons/arrow_right.svg',
            color: Colors.black,
            height: 20,
            width: 20,
          ),
        ),
      ],
    );
  }
}
