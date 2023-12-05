import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class GPPageIndicator extends StatelessWidget {
  const GPPageIndicator({
    required this.controller,
    required this.count,
    required this.dotHeight,
    required this.dotWidth,
    required this.dotColor,
    required this.activeDotColor,
    super.key,
  });

  final PageController controller;
  final int count;
  final double dotHeight;
  final double dotWidth;
  final Color dotColor;
  final Color activeDotColor;

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: controller,
      count: count,
      effect: WormEffect(
        dotHeight: dotHeight,
        dotWidth: dotWidth,
        dotColor: dotColor,
        activeDotColor: activeDotColor,
        type: WormType.thin,
      ),
    );
  }
}
