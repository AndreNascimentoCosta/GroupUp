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
}
