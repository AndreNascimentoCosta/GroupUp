import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/providers/instagrammable_provider.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/models/home_view.dart';
import 'package:groupup/screens/individual_group/components/instagrammable/components/app_bar_instagrammable.dart';
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
    final screenHeight = context.screenHeight;
    final screenWidth = context.screenWidth;
    final isAndroidScreen =
        screenHeight > 820 && screenHeight < 821 && screenWidth < 412;
    final isScreenSize0 = screenHeight < 620 && screenWidth < 350;
    final isScreenSize1 = screenHeight > 650 &&
        screenHeight < 680 &&
        screenWidth > 350 &&
        screenWidth < 380;
    final isScreenSize2 = screenHeight > 820 &&
        screenHeight < 830 &&
        screenWidth > 385 &&
        screenWidth < 395;
    final isScreenSize3 = screenHeight > 835 &&
        screenHeight < 845 &&
        screenWidth > 405 &&
        screenWidth < 415;
    final isScreenSize4 = screenHeight > 800 &&
        screenHeight < 810 &&
        screenWidth > 380 &&
        screenWidth < 400;
    final isScreenSize5 = screenHeight > 770 &&
        screenHeight < 790 &&
        screenWidth > 380 &&
        screenWidth < 400;
    // final isScreenSize2a = screenHeight > 720 &&
    //     screenHeight < 750 &&
    //     screenWidth > 400 &&
    //     screenWidth < 425;
    // final isScreenSize3a = screenHeight > 790 &&
    //     screenHeight < 830 &&
    //     screenWidth > 360 &&
    //     screenWidth < 390;
    // final isScreenSize4a = screenHeight > 830 &&
    //     screenHeight < 860 &&
    //     screenWidth > 380 &&
    //     screenWidth < 400;
    // final isScreenSize5a = screenHeight > 880 &&
    //     screenHeight < 910 &&
    //     screenWidth > 405 &&
    //     screenWidth < 425;
    // final isScreenSize6 = screenHeight > 910 &&
    //     screenHeight < 940 &&
    //     screenWidth > 415 &&
    //     screenWidth < 440;
    final instagrammableProvider = Provider.of<InstagrammableProvider>(context);
    final noPicture = instagrammableProvider.picture6;
    final currentUser = Provider.of<AuthProvider>(context).user;
    if (currentUser == null) {
      Navigator.of(context).pop();
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarInstagrammable(
        isSharing: widget.isSharing,
      ),
      body: SizedBox(
        height: screenHeight * 0.8,
        width: screenWidth,
        child: Stack(
          children: [
            SvgPicture.asset(
              'assets/images/instagrammable.svg',
            ),
            Positioned(
              width: widget.isSharing
                  ? screenWidth * 0.115
                  : isScreenSize0
                      ? screenWidth * 0.12
                      : isScreenSize1
                          ? screenWidth * 0.135
                          : isScreenSize4
                              ? screenWidth * 0.1375
                              : isScreenSize5
                                  ? screenWidth * 0.1325
                                  : screenWidth * 0.145,
              bottom: widget.isSharing
                  ? screenHeight * 0.47
                  : screenHeight * 0.585,
              left: isAndroidScreen
                  ? screenWidth * 0.185
                  : widget.isSharing
                      ? screenWidth * 0.2325
                      : isScreenSize0
                          ? screenWidth * 0.225
                          : isScreenSize1
                              ? screenWidth * 0.21
                              : isScreenSize2
                                  ? screenWidth * 0.175
                                  : isScreenSize3
                                      ? screenWidth * 0.18
                                      : isScreenSize4
                                          ? screenWidth * 0.1835
                                          : isScreenSize5
                                              ? screenWidth * 0.1925
                                              : screenWidth * 0.165,
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
                          ? Colors.transparent
                          : Colors.black,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(
                      widget.isSharing
                          ? screenWidth * 0.115
                          : isScreenSize0
                              ? screenWidth * 0.12
                              : isScreenSize1
                                  ? screenWidth * 0.135
                                  : isScreenSize4
                                      ? screenWidth * 0.1375
                                      : isScreenSize5
                                          ? screenWidth * 0.1325
                                          : screenWidth * 0.145,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      widget.isSharing
                          ? screenWidth * 0.115
                          : isScreenSize0
                              ? screenWidth * 0.12
                              : isScreenSize1
                                  ? screenWidth * 0.135
                                  : isScreenSize4
                                      ? screenWidth * 0.1375
                                      : isScreenSize5
                                          ? screenWidth * 0.1325
                                          : screenWidth * 0.145,
                    ),
                    child: Container(
                      height: widget.isSharing
                          ? screenWidth * 0.115
                          : isScreenSize0
                              ? screenWidth * 0.12
                              : isScreenSize1
                                  ? screenWidth * 0.135
                                  : isScreenSize4
                                      ? screenWidth * 0.1375
                                      : isScreenSize5
                                          ? screenWidth * 0.1325
                                          : screenWidth * 0.145,
                      width: widget.isSharing
                          ? screenWidth * 0.115
                          : isScreenSize0
                              ? screenWidth * 0.12
                              : isScreenSize1
                                  ? screenWidth * 0.135
                                  : isScreenSize4
                                      ? screenWidth * 0.1375
                                      : isScreenSize5
                                          ? screenWidth * 0.1325
                                          : screenWidth * 0.145,
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
                  ? screenWidth * 0.099
                  : isScreenSize0
                      ? screenWidth * 0.105
                      : isScreenSize1
                          ? screenWidth * 0.107
                          : isScreenSize4
                              ? screenWidth * 0.1185
                              : isScreenSize5
                                  ? screenWidth * 0.1175
                                  : screenWidth * 0.127,
              bottom: widget.isSharing
                  ? screenHeight * 0.465
                  : screenHeight * 0.575,
              right: isAndroidScreen
                  ? screenWidth * 0.1625
                  : widget.isSharing
                      ? screenWidth * 0.22
                      : isScreenSize0
                          ? screenWidth * 0.205
                          : isScreenSize1
                              ? screenWidth * 0.2025
                              : isScreenSize2
                                  ? screenWidth * 0.15
                                  : isScreenSize3
                                      ? screenWidth * 0.155
                                      : isScreenSize4
                                          ? screenWidth * 0.16
                                          : isScreenSize5
                                              ? screenWidth * 0.1675
                                              : screenWidth * 0.1415,
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
                          ? Colors.transparent
                          : Colors.black,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(
                      widget.isSharing
                          ? screenWidth * 0.099
                          : isScreenSize0
                              ? screenWidth * 0.105
                              : isScreenSize1
                                  ? screenWidth * 0.107
                                  : isScreenSize4
                                      ? screenWidth * 0.1185
                                      : isScreenSize5
                                          ? screenWidth * 0.1175
                                          : screenWidth * 0.127,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      widget.isSharing
                          ? screenWidth * 0.099
                          : isScreenSize0
                              ? screenWidth * 0.105
                              : isScreenSize1
                                  ? screenWidth * 0.107
                                  : isScreenSize4
                                      ? screenWidth * 0.1185
                                      : isScreenSize5
                                          ? screenWidth * 0.1175
                                          : screenWidth * 0.127,
                    ),
                    child: Container(
                      height: widget.isSharing
                          ? screenWidth * 0.099
                          : isScreenSize0
                              ? screenWidth * 0.105
                              : isScreenSize1
                                  ? screenWidth * 0.107
                                  : isScreenSize4
                                      ? screenWidth * 0.1185
                                      : isScreenSize5
                                          ? screenWidth * 0.1175
                                          : screenWidth * 0.127,
                      width: widget.isSharing
                          ? screenWidth * 0.099
                          : isScreenSize0
                              ? screenWidth * 0.105
                              : isScreenSize1
                                  ? screenWidth * 0.107
                                  : isScreenSize4
                                      ? screenWidth * 0.1185
                                      : isScreenSize5
                                          ? screenWidth * 0.1175
                                          : screenWidth * 0.127,
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
                  ? screenWidth * 0.125
                  : isScreenSize0
                      ? screenWidth * 0.14
                      : isScreenSize1
                          ? screenWidth * 0.15
                          : isScreenSize4
                              ? screenWidth * 0.155
                              : isScreenSize5
                                  ? screenWidth * 0.1525
                                  : screenWidth * 0.165,
              bottom: widget.isSharing
                  ? screenHeight * 0.21575
                  : screenHeight * 0.267,
              right: isAndroidScreen
                  ? screenWidth * 0.1325
                  : widget.isSharing
                      ? screenWidth * 0.1925
                      : isScreenSize0
                          ? screenWidth * 0.1775
                          : isScreenSize1
                              ? screenWidth * 0.17
                              : isScreenSize2
                                  ? screenWidth * 0.12
                                  : isScreenSize3
                                      ? screenWidth * 0.125
                                      : isScreenSize4
                                          ? screenWidth * 0.1325
                                          : isScreenSize5
                                              ? screenWidth * 0.1425
                                              : screenWidth * 0.1125,
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
                          ? Colors.transparent
                          : Colors.black,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(
                      widget.isSharing
                          ? screenWidth * 0.125
                          : isScreenSize0
                              ? screenWidth * 0.14
                              : isScreenSize1
                                  ? screenWidth * 0.15
                                  : isScreenSize4
                                      ? screenWidth * 0.155
                                      : isScreenSize5
                                          ? screenWidth * 0.1525
                                          : screenWidth * 0.165,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      widget.isSharing
                          ? screenWidth * 0.125
                          : isScreenSize0
                              ? screenWidth * 0.14
                              : isScreenSize1
                                  ? screenWidth * 0.15
                                  : isScreenSize4
                                      ? screenWidth * 0.155
                                      : isScreenSize5
                                          ? screenWidth * 0.1525
                                          : screenWidth * 0.165,
                    ),
                    child: Container(
                      height: widget.isSharing
                          ? screenWidth * 0.125
                          : isScreenSize0
                              ? screenWidth * 0.14
                              : isScreenSize1
                                  ? screenWidth * 0.15
                                  : isScreenSize4
                                      ? screenWidth * 0.155
                                      : isScreenSize5
                                          ? screenWidth * 0.1525
                                          : screenWidth * 0.165,
                      width: widget.isSharing
                          ? screenWidth * 0.125
                          : isScreenSize0
                              ? screenWidth * 0.14
                              : isScreenSize1
                                  ? screenWidth * 0.15
                                  : isScreenSize4
                                      ? screenWidth * 0.155
                                      : isScreenSize5
                                          ? screenWidth * 0.1525
                                          : screenWidth * 0.165,
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
                  ? screenWidth * 0.127
                  : isScreenSize0
                      ? screenWidth * 0.13
                      : isScreenSize1
                          ? screenWidth * 0.1325
                          : isScreenSize5
                              ? screenWidth * 0.1475
                              : screenWidth * 0.1575,
              bottom: widget.isSharing
                  ? screenHeight * 0.246
                  : screenHeight * 0.305,
              left: isAndroidScreen
                  ? screenWidth * 0.1275
                  : widget.isSharing
                      ? screenWidth * 0.181
                      : isScreenSize0
                          ? screenWidth * 0.1725
                          : isScreenSize1
                              ? screenWidth * 0.1715
                              : isScreenSize2
                                  ? screenWidth * 0.1125
                                  : isScreenSize3
                                      ? screenWidth * 0.12
                                      : isScreenSize4
                                          ? screenWidth * 0.12
                                          : isScreenSize5
                                              ? screenWidth * 0.1325
                                              : screenWidth * 0.103,
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
                          ? Colors.transparent
                          : Colors.black,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(
                      widget.isSharing
                          ? screenWidth * 0.127
                          : isScreenSize0
                              ? screenWidth * 0.13
                              : isScreenSize1
                                  ? screenWidth * 0.1325
                                  : isScreenSize5
                                      ? screenWidth * 0.1475
                                      : screenWidth * 0.1575,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      widget.isSharing
                          ? screenWidth * 0.127
                          : isScreenSize0
                              ? screenWidth * 0.13
                              : isScreenSize1
                                  ? screenWidth * 0.1325
                                  : isScreenSize5
                                      ? screenWidth * 0.1475
                                      : screenWidth * 0.1575,
                    ),
                    child: Container(
                      height: widget.isSharing
                          ? screenWidth * 0.127
                          : isScreenSize0
                              ? screenWidth * 0.13
                              : isScreenSize1
                                  ? screenWidth * 0.1325
                                  : isScreenSize5
                                      ? screenWidth * 0.1475
                                      : screenWidth * 0.1575,
                      width: widget.isSharing
                          ? screenWidth * 0.127
                          : isScreenSize0
                              ? screenWidth * 0.13
                              : isScreenSize1
                                  ? screenWidth * 0.1325
                                  : isScreenSize5
                                      ? screenWidth * 0.1475
                                      : screenWidth * 0.1575,
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
                  ? screenWidth * 0.145
                  : isScreenSize0
                      ? screenWidth * 0.145
                      : screenWidth * 0.18,
              bottom: widget.isSharing
                  ? screenHeight * 0.3025
                  : screenHeight * 0.375,
              right: widget.isSharing
                  ? screenWidth * 0.4425
                  : isScreenSize0
                      ? screenWidth * 0.445
                      : screenWidth * 0.43,
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
                          ? Colors.transparent
                          : Colors.black,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(widget.isSharing
                        ? screenWidth * 0.145
                        : isScreenSize0
                            ? screenWidth * 0.145
                            : screenWidth * 0.18),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      widget.isSharing
                          ? screenWidth * 0.145
                          : isScreenSize0
                              ? screenWidth * 0.145
                              : screenWidth * 0.18,
                    ),
                    child: Container(
                      height: widget.isSharing
                          ? screenWidth * 0.145
                          : isScreenSize0
                              ? screenWidth * 0.145
                              : screenWidth * 0.18,
                      width: widget.isSharing
                          ? screenWidth * 0.145
                          : isScreenSize0
                              ? screenWidth * 0.145
                              : screenWidth * 0.18,
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
                  ? screenWidth * 0.14
                  : isScreenSize0
                      ? screenWidth * 0.155
                      : screenWidth * 0.17,
              bottom: widget.isSharing
                  ? screenHeight * 0.3525
                  : isScreenSize0
                      ? screenHeight * 0.43
                      : screenHeight * 0.445,
              right:
                  widget.isSharing ? screenWidth * 0.4425 : screenWidth * 0.435,
              child: SvgPicture.asset(
                'assets/icons/crown.svg',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
