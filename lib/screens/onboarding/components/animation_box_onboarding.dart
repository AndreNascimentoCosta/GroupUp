import 'package:flutter/material.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:rive/rive.dart';

class AnimationBox extends StatelessWidget {
  const AnimationBox({
    required this.animation,
    super.key,
  });

  final String animation;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.screenHeight * 0.475,
      width: context.screenHeight * 0.475,
      child: RiveAnimation.asset(
        animation,
        fit: BoxFit.contain,
      ),
    );
  }
}
