import 'package:flutter/material.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';

class GPLoading extends StatelessWidget {
  const GPLoading({
    this.color = GPColors.black,
    super.key,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator.adaptive(
        backgroundColor: color,
      ),
    );
  }
}
