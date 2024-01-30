import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:groupup/core/extensions/gp_navigator_extension.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/providers/instagrammable_provider.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/utils/icons/gp_icons.dart';
import 'package:groupup/core/utils/images/gp_images.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/widgets/icons/gp_icon.dart';
import 'package:groupup/models/home_view.dart';
import 'package:groupup/modules/individual_group/components/instagrammable/components/app_bar_instagrammable.dart';
import 'package:provider/provider.dart';

class BodyInstagrammable extends StatefulWidget {
  const BodyInstagrammable({
    super.key,
    this.isSharing = false,
  });
  final bool isSharing;

  @override
  State<BodyInstagrammable> createState() => _BodyInstagrammableState();
}

class _BodyInstagrammableState extends State<BodyInstagrammable> {
  final homeViewModel = HomeViewModel();

  @override
  Widget build(BuildContext context) {
    final isAndroidScreen =
        context.screenHeight > 820 && context.screenHeight < 821 && context.screenWidth < 412;
    final isScreenSize0 = context.screenHeight < 620 && context.screenWidth < 350;
    final isScreenSize1 = context.screenHeight > 650 &&
        context.screenHeight < 680 &&
        context.screenWidth > 350 &&
        context.screenWidth < 380;
    final isScreenSize2 = context.screenHeight > 820 &&
        context.screenHeight < 830 &&
        context.screenWidth > 385 &&
        context.screenWidth < 395;
    final isScreenSize3 = context.screenHeight > 835 &&
        context.screenHeight < 845 &&
        context.screenWidth > 405 &&
        context.screenWidth < 415;
    final isScreenSize4 = context.screenHeight > 800 &&
        context.screenHeight < 810 &&
        context.screenWidth > 380 &&
        context.screenWidth < 400;
    final isScreenSize5 = context.screenHeight > 770 &&
        context.screenHeight < 790 &&
        context.screenWidth > 380 &&
        context.screenWidth < 400;
    // final isScreenSize2a = context.screenHeight > 720 &&
    //     context.screenHeight < 750 &&
    //     context.screenWidth > 400 &&
    //     context.screenWidth < 425;
    // final isScreenSize3a = context.screenHeight > 790 &&
    //     context.screenHeight < 830 &&
    //     context.screenWidth > 360 &&
    //     context.screenWidth < 390;
    // final isScreenSize4a = context.screenHeight > 830 &&
    //     context.screenHeight < 860 &&
    //     context.screenWidth > 380 &&
    //     context.screenWidth < 400;
    // final isScreenSize5a = context.screenHeight > 880 &&
    //     context.screenHeight < 910 &&
    //     context.screenWidth > 405 &&
    //     context.screenWidth < 425;
    // final isScreenSize6 = context.screenHeight > 910 &&
    //     context.screenHeight < 940 &&
    //     context.screenWidth > 415 &&
    //     context.screenWidth < 440;
    final instagrammableProvider = Provider.of<InstagrammableProvider>(context);
    final noPicture = instagrammableProvider.picture6;
    final currentUser = Provider.of<AuthProvider>(context).user;
    if (currentUser == null) {
      context.pop();
    }
    return Scaffold(
      backgroundColor: GPColors.white,
      appBar: AppBarInstagrammable(
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
            Positioned(
              width: widget.isSharing
                  ? context.screenWidth * 0.115
                  : isScreenSize0
                      ? context.screenWidth * 0.12
                      : isScreenSize1
                          ? context.screenWidth * 0.135
                          : isScreenSize4
                              ? context.screenWidth * 0.1375
                              : isScreenSize5
                                  ? context.screenWidth * 0.1325
                                  : context.screenWidth * 0.145,
              bottom: widget.isSharing
                  ? context.screenHeight * 0.47
                  : context.screenHeight * 0.585,
              left: isAndroidScreen
                  ? context.screenWidth * 0.185
                  : widget.isSharing
                      ? context.screenWidth * 0.2325
                      : isScreenSize0
                          ? context.screenWidth * 0.225
                          : isScreenSize1
                              ? context.screenWidth * 0.21
                              : isScreenSize2
                                  ? context.screenWidth * 0.175
                                  : isScreenSize3
                                      ? context.screenWidth * 0.18
                                      : isScreenSize4
                                          ? context.screenWidth * 0.1835
                                          : isScreenSize5
                                              ? context.screenWidth * 0.1925
                                              : context.screenWidth * 0.165,
              child: ButtonCommonStyle(
                onPressed: () {
                  Provider.of<MixPanelProvider>(context, listen: false)
                      .logEvent(eventName: 'Instagrammable - Picture 1');
                  instagrammableProvider.choosePicture(
                      context, SetPictureType.picture1);
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: instagrammableProvider.picture1 == noPicture
                          ? GPColors.transparent
                          : GPColors.black,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(
                      widget.isSharing
                          ? context.screenWidth * 0.115
                          : isScreenSize0
                              ? context.screenWidth * 0.12
                              : isScreenSize1
                                  ? context.screenWidth * 0.135
                                  : isScreenSize4
                                      ? context.screenWidth * 0.1375
                                      : isScreenSize5
                                          ? context.screenWidth * 0.1325
                                          : context.screenWidth * 0.145,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      widget.isSharing
                          ? context.screenWidth * 0.115
                          : isScreenSize0
                              ? context.screenWidth * 0.12
                              : isScreenSize1
                                  ? context.screenWidth * 0.135
                                  : isScreenSize4
                                      ? context.screenWidth * 0.1375
                                      : isScreenSize5
                                          ? context.screenWidth * 0.1325
                                          : context.screenWidth * 0.145,
                    ),
                    child: Container(
                      height: widget.isSharing
                          ? context.screenWidth * 0.115
                          : isScreenSize0
                              ? context.screenWidth * 0.12
                              : isScreenSize1
                                  ? context.screenWidth * 0.135
                                  : isScreenSize4
                                      ? context.screenWidth * 0.1375
                                      : isScreenSize5
                                          ? context.screenWidth * 0.1325
                                          : context.screenWidth * 0.145,
                      width: widget.isSharing
                          ? context.screenWidth * 0.115
                          : isScreenSize0
                              ? context.screenWidth * 0.12
                              : isScreenSize1
                                  ? context.screenWidth * 0.135
                                  : isScreenSize4
                                      ? context.screenWidth * 0.1375
                                      : isScreenSize5
                                          ? context.screenWidth * 0.1325
                                          : context.screenWidth * 0.145,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            instagrammableProvider.picture1,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              width: widget.isSharing
                  ? context.screenWidth * 0.099
                  : isScreenSize0
                      ? context.screenWidth * 0.105
                      : isScreenSize1
                          ? context.screenWidth * 0.107
                          : isScreenSize4
                              ? context.screenWidth * 0.1185
                              : isScreenSize5
                                  ? context.screenWidth * 0.1175
                                  : context.screenWidth * 0.127,
              bottom: widget.isSharing
                  ? context.screenHeight * 0.465
                  : context.screenHeight * 0.575,
              right: isAndroidScreen
                  ? context.screenWidth * 0.1625
                  : widget.isSharing
                      ? context.screenWidth * 0.22
                      : isScreenSize0
                          ? context.screenWidth * 0.205
                          : isScreenSize1
                              ? context.screenWidth * 0.2025
                              : isScreenSize2
                                  ? context.screenWidth * 0.15
                                  : isScreenSize3
                                      ? context.screenWidth * 0.155
                                      : isScreenSize4
                                          ? context.screenWidth * 0.16
                                          : isScreenSize5
                                              ? context.screenWidth * 0.1675
                                              : context.screenWidth * 0.1415,
              child: ButtonCommonStyle(
                onPressed: () {
                  Provider.of<MixPanelProvider>(context, listen: false)
                      .logEvent(eventName: 'Instagrammable - Picture 2');
                  Provider.of<InstagrammableProvider>(context, listen: false)
                      .choosePicture(context, SetPictureType.picture2);
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: instagrammableProvider.picture2 == noPicture
                          ? GPColors.transparent
                          : GPColors.black,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(
                      widget.isSharing
                          ? context.screenWidth * 0.099
                          : isScreenSize0
                              ? context.screenWidth * 0.105
                              : isScreenSize1
                                  ? context.screenWidth * 0.107
                                  : isScreenSize4
                                      ? context.screenWidth * 0.1185
                                      : isScreenSize5
                                          ? context.screenWidth * 0.1175
                                          : context.screenWidth * 0.127,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      widget.isSharing
                          ? context.screenWidth * 0.099
                          : isScreenSize0
                              ? context.screenWidth * 0.105
                              : isScreenSize1
                                  ? context.screenWidth * 0.107
                                  : isScreenSize4
                                      ? context.screenWidth * 0.1185
                                      : isScreenSize5
                                          ? context.screenWidth * 0.1175
                                          : context.screenWidth * 0.127,
                    ),
                    child: Container(
                      height: widget.isSharing
                          ? context.screenWidth * 0.099
                          : isScreenSize0
                              ? context.screenWidth * 0.105
                              : isScreenSize1
                                  ? context.screenWidth * 0.107
                                  : isScreenSize4
                                      ? context.screenWidth * 0.1185
                                      : isScreenSize5
                                          ? context.screenWidth * 0.1175
                                          : context.screenWidth * 0.127,
                      width: widget.isSharing
                          ? context.screenWidth * 0.099
                          : isScreenSize0
                              ? context.screenWidth * 0.105
                              : isScreenSize1
                                  ? context.screenWidth * 0.107
                                  : isScreenSize4
                                      ? context.screenWidth * 0.1185
                                      : isScreenSize5
                                          ? context.screenWidth * 0.1175
                                          : context.screenWidth * 0.127,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            instagrammableProvider.picture2,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              width: widget.isSharing
                  ? context.screenWidth * 0.125
                  : isScreenSize0
                      ? context.screenWidth * 0.14
                      : isScreenSize1
                          ? context.screenWidth * 0.15
                          : isScreenSize4
                              ? context.screenWidth * 0.155
                              : isScreenSize5
                                  ? context.screenWidth * 0.1525
                                  : context.screenWidth * 0.165,
              bottom: widget.isSharing
                  ? context.screenHeight * 0.21575
                  : context.screenHeight * 0.267,
              right: isAndroidScreen
                  ? context.screenWidth * 0.1325
                  : widget.isSharing
                      ? context.screenWidth * 0.1925
                      : isScreenSize0
                          ? context.screenWidth * 0.1775
                          : isScreenSize1
                              ? context.screenWidth * 0.17
                              : isScreenSize2
                                  ? context.screenWidth * 0.12
                                  : isScreenSize3
                                      ? context.screenWidth * 0.125
                                      : isScreenSize4
                                          ? context.screenWidth * 0.1325
                                          : isScreenSize5
                                              ? context.screenWidth * 0.1425
                                              : context.screenWidth * 0.1125,
              child: ButtonCommonStyle(
                onPressed: () {
                  Provider.of<MixPanelProvider>(context, listen: false)
                      .logEvent(eventName: 'Instagrammable - Picture 3');
                  Provider.of<InstagrammableProvider>(context, listen: false)
                      .choosePicture(context, SetPictureType.picture3);
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: instagrammableProvider.picture3 == noPicture
                          ? GPColors.transparent
                          : GPColors.black,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(
                      widget.isSharing
                          ? context.screenWidth * 0.125
                          : isScreenSize0
                              ? context.screenWidth * 0.14
                              : isScreenSize1
                                  ? context.screenWidth * 0.15
                                  : isScreenSize4
                                      ? context.screenWidth * 0.155
                                      : isScreenSize5
                                          ? context.screenWidth * 0.1525
                                          : context.screenWidth * 0.165,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      widget.isSharing
                          ? context.screenWidth * 0.125
                          : isScreenSize0
                              ? context.screenWidth * 0.14
                              : isScreenSize1
                                  ? context.screenWidth * 0.15
                                  : isScreenSize4
                                      ? context.screenWidth * 0.155
                                      : isScreenSize5
                                          ? context.screenWidth * 0.1525
                                          : context.screenWidth * 0.165,
                    ),
                    child: Container(
                      height: widget.isSharing
                          ? context.screenWidth * 0.125
                          : isScreenSize0
                              ? context.screenWidth * 0.14
                              : isScreenSize1
                                  ? context.screenWidth * 0.15
                                  : isScreenSize4
                                      ? context.screenWidth * 0.155
                                      : isScreenSize5
                                          ? context.screenWidth * 0.1525
                                          : context.screenWidth * 0.165,
                      width: widget.isSharing
                          ? context.screenWidth * 0.125
                          : isScreenSize0
                              ? context.screenWidth * 0.14
                              : isScreenSize1
                                  ? context.screenWidth * 0.15
                                  : isScreenSize4
                                      ? context.screenWidth * 0.155
                                      : isScreenSize5
                                          ? context.screenWidth * 0.1525
                                          : context.screenWidth * 0.165,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            instagrammableProvider.picture3,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              width: widget.isSharing
                  ? context.screenWidth * 0.127
                  : isScreenSize0
                      ? context.screenWidth * 0.13
                      : isScreenSize1
                          ? context.screenWidth * 0.1325
                          : isScreenSize5
                              ? context.screenWidth * 0.1475
                              : context.screenWidth * 0.1575,
              bottom: widget.isSharing
                  ? context.screenHeight * 0.246
                  : context.screenHeight * 0.305,
              left: isAndroidScreen
                  ? context.screenWidth * 0.1275
                  : widget.isSharing
                      ? context.screenWidth * 0.181
                      : isScreenSize0
                          ? context.screenWidth * 0.1725
                          : isScreenSize1
                              ? context.screenWidth * 0.1715
                              : isScreenSize2
                                  ? context.screenWidth * 0.1125
                                  : isScreenSize3
                                      ? context.screenWidth * 0.12
                                      : isScreenSize4
                                          ? context.screenWidth * 0.12
                                          : isScreenSize5
                                              ? context.screenWidth * 0.1325
                                              : context.screenWidth * 0.103,
              child: ButtonCommonStyle(
                onPressed: () {
                  Provider.of<MixPanelProvider>(context, listen: false)
                      .logEvent(eventName: 'Instagrammable - Picture 4');
                  Provider.of<InstagrammableProvider>(context, listen: false)
                      .choosePicture(context, SetPictureType.picture4);
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: instagrammableProvider.picture4 == noPicture
                          ? GPColors.transparent
                          : GPColors.black,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(
                      widget.isSharing
                          ? context.screenWidth * 0.127
                          : isScreenSize0
                              ? context.screenWidth * 0.13
                              : isScreenSize1
                                  ? context.screenWidth * 0.1325
                                  : isScreenSize5
                                      ? context.screenWidth * 0.1475
                                      : context.screenWidth * 0.1575,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      widget.isSharing
                          ? context.screenWidth * 0.127
                          : isScreenSize0
                              ? context.screenWidth * 0.13
                              : isScreenSize1
                                  ? context.screenWidth * 0.1325
                                  : isScreenSize5
                                      ? context.screenWidth * 0.1475
                                      : context.screenWidth * 0.1575,
                    ),
                    child: Container(
                      height: widget.isSharing
                          ? context.screenWidth * 0.127
                          : isScreenSize0
                              ? context.screenWidth * 0.13
                              : isScreenSize1
                                  ? context.screenWidth * 0.1325
                                  : isScreenSize5
                                      ? context.screenWidth * 0.1475
                                      : context.screenWidth * 0.1575,
                      width: widget.isSharing
                          ? context.screenWidth * 0.127
                          : isScreenSize0
                              ? context.screenWidth * 0.13
                              : isScreenSize1
                                  ? context.screenWidth * 0.1325
                                  : isScreenSize5
                                      ? context.screenWidth * 0.1475
                                      : context.screenWidth * 0.1575,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            instagrammableProvider.picture4,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              width: widget.isSharing
                  ? context.screenWidth * 0.145
                  : isScreenSize0
                      ? context.screenWidth * 0.145
                      : context.screenWidth * 0.18,
              bottom: widget.isSharing
                  ? context.screenHeight * 0.3025
                  : context.screenHeight * 0.375,
              right: widget.isSharing
                  ? context.screenWidth * 0.4425
                  : isScreenSize0
                      ? context.screenWidth * 0.445
                      : context.screenWidth * 0.43,
              child: ButtonCommonStyle(
                onPressed: () {
                  Provider.of<MixPanelProvider>(context, listen: false)
                      .logEvent(eventName: 'Instagrammable - Choose Picture 5');
                  Provider.of<InstagrammableProvider>(context, listen: false)
                      .choosePicture(context, SetPictureType.picture5);
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: instagrammableProvider.picture5 == noPicture
                          ? GPColors.transparent
                          : GPColors.black,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(widget.isSharing
                        ? context.screenWidth * 0.145
                        : isScreenSize0
                            ? context.screenWidth * 0.145
                            : context.screenWidth * 0.18),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      widget.isSharing
                          ? context.screenWidth * 0.145
                          : isScreenSize0
                              ? context.screenWidth * 0.145
                              : context.screenWidth * 0.18,
                    ),
                    child: Container(
                      height: widget.isSharing
                          ? context.screenWidth * 0.145
                          : isScreenSize0
                              ? context.screenWidth * 0.145
                              : context.screenWidth * 0.18,
                      width: widget.isSharing
                          ? context.screenWidth * 0.145
                          : isScreenSize0
                              ? context.screenWidth * 0.145
                              : context.screenWidth * 0.18,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            instagrammableProvider.picture5,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              width: widget.isSharing
                  ? context.screenWidth * 0.14
                  : isScreenSize0
                      ? context.screenWidth * 0.155
                      : context.screenWidth * 0.17,
              bottom: widget.isSharing
                  ? context.screenHeight * 0.3525
                  : isScreenSize0
                      ? context.screenHeight * 0.43
                      : context.screenHeight * 0.445,
              right:
                  widget.isSharing ? context.screenWidth * 0.4425 : context.screenWidth * 0.435,
              child: const GPIcon(GPIcons.crown),
            ),
          ],
        ),
      ),
    );
  }
}
