import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:groupup/core/extensions/gp_navigator_extension.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/utils/images/gp_images.dart';
import 'package:groupup/models/home_view_model.dart';
import 'package:groupup/modules/individual_group/components/instagrammable/components/instagrammable_app_bar.dart';
import 'package:provider/provider.dart';

enum ScreenSizes {
  size0,
  size1,
  size2,
  size3,
  size4,
  size5;

  ScreenSizes screenSize(BuildContext context) {
    if (context.isScreenSize0) {
      return ScreenSizes.size0;
    } else if (context.isScreenSize1) {
      return ScreenSizes.size1;
    } else if (context.isScreenSize2) {
      return ScreenSizes.size2;
    } else if (context.isScreenSize3) {
      return ScreenSizes.size3;
    } else if (context.isScreenSize4) {
      return ScreenSizes.size4;
    } else if (context.isScreenSize5) {
      return ScreenSizes.size5;
    } else {
      return ScreenSizes.size0;
    }
  }
}

class InstagrammableBody extends StatefulWidget {
  const InstagrammableBody({
    super.key,
    this.isSharing = false,
  });
  final bool isSharing;

  @override
  State<InstagrammableBody> createState() => _InstagrammableBodyState();
}

class _InstagrammableBodyState extends State<InstagrammableBody> {
  final homeViewModel = HomeViewModel();

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<AuthProvider>(context).user;
    if (currentUser == null) {
      context.pop();
    }
    return Scaffold(
      backgroundColor: GPColors.white,
      appBar: InstagrammableAppBar(
        isSharing: widget.isSharing,
      ),
      body: SizedBox(
        height: context.screenHeight * 0.8,
        width: context.screenWidth,
        child: Stack(
          children: [
            SvgPicture.asset(
              GPImages.instagrammable,
            ),
          ],
        ),
      ),
    );
  }

  double getSize(
    BuildContext context,
    bool isSharing,
    double sizeStandardWidthFactor, {
    double? sharingWidthFactor,
    double? sizeAndroidWidthFactor,
    double? size0WidthFactor,
    double? size1WidthFactor,
    double? size2WidthFactor,
    double? size3WidthFactor,
    double? size4WidthFactor,
    double? size5WidthFactor,
  }) {
    if (isSharing) {
      return context.screenWidth *
          (sharingWidthFactor ?? sizeStandardWidthFactor);
    } else if (ScreenSizes.size0.screenSize(context) == ScreenSizes.size0) {
      return context.screenWidth *
          (size0WidthFactor ?? sizeStandardWidthFactor);
    } else if (ScreenSizes.size1.screenSize(context) == ScreenSizes.size1) {
      return context.screenWidth *
          (size1WidthFactor ?? sizeStandardWidthFactor);
    } else if (ScreenSizes.size2.screenSize(context) == ScreenSizes.size2) {
      return context.screenWidth *
          (size2WidthFactor ?? sizeStandardWidthFactor);
    } else if (ScreenSizes.size3.screenSize(context) == ScreenSizes.size3) {
      return context.screenWidth *
          (size3WidthFactor ?? sizeStandardWidthFactor);
    } else if (ScreenSizes.size4.screenSize(context) == ScreenSizes.size4) {
      return context.screenWidth *
          (size4WidthFactor ?? sizeStandardWidthFactor);
    } else if (ScreenSizes.size5.screenSize(context) == ScreenSizes.size5) {
      return context.screenWidth *
          (size5WidthFactor ?? sizeStandardWidthFactor);
    } else if (context.isAndroidScreen) {
      return context.screenWidth *
          (sizeAndroidWidthFactor ?? sizeStandardWidthFactor);
    } else {
      return context.screenWidth * sizeStandardWidthFactor;
    }
  }
}
