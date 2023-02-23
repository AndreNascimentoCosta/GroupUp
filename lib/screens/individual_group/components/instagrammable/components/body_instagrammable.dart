import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenHeight < 800 || screenWidth < 350;
    final isAndroidScreen =
        screenHeight > 820 && screenHeight < 821 || screenWidth < 412;
    final instagrammableProvider = Provider.of<InstagrammableProvider>(context);
    final noPicture = instagrammableProvider.picture6;
    final currentUser = Provider.of<AuthProvider>(context).user;
    if (currentUser == null) {
      Navigator.of(context).pop();
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarInstagrammable(),
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
                  : isSmallScreen
                      ? screenWidth * 0.12
                      : screenWidth * 0.145,
              bottom: widget.isSharing
                  ? screenHeight * 0.4715
                  : screenHeight * 0.585,
              left: isAndroidScreen
                  ? screenWidth * 0.185
                  : widget.isSharing
                      ? screenWidth * 0.2325
                      : isSmallScreen
                          ? screenWidth * 0.225
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
                          : isSmallScreen
                              ? screenWidth * 0.12
                              : screenWidth * 0.145,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(widget.isSharing
                        ? screenWidth * 0.115
                        : isSmallScreen
                            ? screenWidth * 0.12
                            : screenWidth * 0.145),
                    child: CachedNetworkImage(
                      imageUrl: instagrammableProvider.picture1,
                      fadeInDuration: const Duration(milliseconds: 100),
                      height: widget.isSharing
                          ? screenWidth * 0.115
                          : isSmallScreen
                              ? screenWidth * 0.12
                              : screenWidth * 0.145,
                      width: widget.isSharing
                          ? screenWidth * 0.115
                          : isSmallScreen
                              ? screenWidth * 0.12
                              : screenWidth * 0.145,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              width: widget.isSharing
                  ? screenWidth * 0.099
                  : isSmallScreen
                      ? screenWidth * 0.105
                      : screenWidth * 0.127,
              bottom: widget.isSharing
                  ? screenHeight * 0.465
                  : screenHeight * 0.575,
              right: isAndroidScreen
                  ? screenWidth * 0.1625
                  : widget.isSharing
                      ? screenWidth * 0.2125
                      : isSmallScreen
                          ? screenWidth * 0.205
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
                          : isSmallScreen
                              ? screenWidth * 0.105
                              : screenWidth * 0.127,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      widget.isSharing
                          ? screenWidth * 0.099
                          : isSmallScreen
                              ? screenWidth * 0.105
                              : screenWidth * 0.127,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: instagrammableProvider.picture2,
                      height: widget.isSharing
                          ? screenWidth * 0.099
                          : isSmallScreen
                              ? screenWidth * 0.105
                              : screenWidth * 0.127,
                      width: widget.isSharing
                          ? screenWidth * 0.099
                          : isSmallScreen
                              ? screenWidth * 0.105
                              : screenWidth * 0.127,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              width: widget.isSharing
                  ? screenWidth * 0.125
                  : isSmallScreen
                      ? screenWidth * 0.14
                      : screenWidth * 0.165,
              bottom: widget.isSharing
                  ? screenHeight * 0.21575
                  : screenHeight * 0.267,
              right: isAndroidScreen
                  ? screenWidth * 0.1325
                  : widget.isSharing
                      ? screenWidth * 0.1925
                      : isSmallScreen
                          ? screenWidth * 0.1775
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
                    borderRadius: BorderRadius.circular(widget.isSharing
                        ? screenWidth * 0.125
                        : isSmallScreen
                            ? screenWidth * 0.14
                            : screenWidth * 0.165),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(widget.isSharing
                        ? screenWidth * 0.125
                        : isSmallScreen
                            ? screenWidth * 0.14
                            : screenWidth * 0.165),
                    child: CachedNetworkImage(
                      imageUrl: instagrammableProvider.picture3,
                      fadeInDuration: const Duration(milliseconds: 100),
                      height: widget.isSharing
                          ? screenWidth * 0.125
                          : isSmallScreen
                              ? screenWidth * 0.14
                              : screenWidth * 0.165,
                      width: widget.isSharing
                          ? screenWidth * 0.125
                          : isSmallScreen
                              ? screenWidth * 0.14
                              : screenWidth * 0.165,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              width: widget.isSharing
                  ? screenWidth * 0.127
                  : isSmallScreen
                      ? screenWidth * 0.13
                      : screenWidth * 0.1575,
              bottom: widget.isSharing
                  ? screenHeight * 0.246
                  : screenHeight * 0.305,
              left: isAndroidScreen
                  ? screenWidth * 0.1275
                  : widget.isSharing
                      ? screenWidth * 0.181
                      : isSmallScreen
                          ? screenWidth * 0.1725
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
                    borderRadius: BorderRadius.circular(widget.isSharing
                        ? screenWidth * 0.127
                        : isSmallScreen
                            ? screenWidth * 0.13
                            : screenWidth * 0.1575),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(widget.isSharing
                        ? screenWidth * 0.127
                        : isSmallScreen
                            ? screenWidth * 0.13
                            : screenWidth * 0.1575),
                    child: CachedNetworkImage(
                      imageUrl: instagrammableProvider.picture4,
                      fadeInDuration: const Duration(milliseconds: 100),
                      height: widget.isSharing
                          ? screenWidth * 0.127
                          : isSmallScreen
                              ? screenWidth * 0.13
                              : screenWidth * 0.1575,
                      width: widget.isSharing
                          ? screenWidth * 0.127
                          : isSmallScreen
                              ? screenWidth * 0.13
                              : screenWidth * 0.1575,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              width: widget.isSharing
                  ? screenWidth * 0.145
                  : isSmallScreen
                      ? screenWidth * 0.145
                      : screenWidth * 0.18,
              bottom: widget.isSharing
                  ? screenHeight * 0.3025
                  : screenHeight * 0.375,
              right: widget.isSharing
                  ? screenWidth * 0.4425
                  : isSmallScreen
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
                        : isSmallScreen
                            ? screenWidth * 0.145
                            : screenWidth * 0.18),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(widget.isSharing
                        ? screenWidth * 0.145
                        : isSmallScreen
                            ? screenWidth * 0.145
                            : screenWidth * 0.18),
                    child: CachedNetworkImage(
                      imageUrl: instagrammableProvider.picture5,
                      fadeInDuration: const Duration(milliseconds: 100),
                      height: widget.isSharing
                          ? screenWidth * 0.145
                          : isSmallScreen
                              ? screenWidth * 0.145
                              : screenWidth * 0.18,
                      width: widget.isSharing
                          ? screenWidth * 0.145
                          : isSmallScreen
                              ? screenWidth * 0.145
                              : screenWidth * 0.18,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              width: widget.isSharing
                  ? screenWidth * 0.14
                  : isSmallScreen
                      ? screenWidth * 0.155
                      : screenWidth * 0.17,
              bottom: widget.isSharing
                  ? screenHeight * 0.3525
                  : isSmallScreen
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
