import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/providers/instagrammable_provider.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/models/home_view.dart';
import 'package:groupup/screens/individual_group/components/instagrammable/components/app_bar_instagrammable.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

class BodyInstagrammable extends StatefulWidget {
  const BodyInstagrammable({super.key});

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
    final instagrammableProvider = Provider.of<InstagrammableProvider>(context);
    final noPicture = instagrammableProvider.picture6;
    final currentUser = Provider.of<AuthProvider>(context).user;
    if (currentUser == null) {
      Navigator.of(context).pop();
    }
    return Screenshot(
      controller: instagrammableProvider.screenshotController,
      child: Scaffold(
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
                width: isSmallScreen ? screenWidth * 0.12 : screenWidth * 0.145,
                bottom: screenHeight * 0.585,
                left: isSmallScreen ? screenWidth * 0.225 : screenWidth * 0.165,
                child: ButtonCommonStyle(
                  onPressed: () {
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
                        isSmallScreen
                            ? screenWidth * 0.12
                            : screenWidth * 0.145,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(isSmallScreen
                          ? screenWidth * 0.12
                          : screenWidth * 0.145),
                      child: CachedNetworkImage(
                        imageUrl: instagrammableProvider.picture1,
                        fadeInDuration: const Duration(milliseconds: 100),
                        height: isSmallScreen
                            ? screenWidth * 0.12
                            : screenWidth * 0.145,
                        width: isSmallScreen
                            ? screenWidth * 0.12
                            : screenWidth * 0.145,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                width:
                    isSmallScreen ? screenWidth * 0.105 : screenWidth * 0.127,
                bottom: screenHeight * 0.575,
                right:
                    isSmallScreen ? screenWidth * 0.205 : screenWidth * 0.1415,
                child: ButtonCommonStyle(
                  onPressed: () {
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
                      borderRadius: BorderRadius.circular(isSmallScreen
                          ? screenWidth * 0.105
                          : screenWidth * 0.127),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(isSmallScreen
                          ? screenWidth * 0.105
                          : screenWidth * 0.127),
                      child: CachedNetworkImage(
                        imageUrl: instagrammableProvider.picture2,
                        height: isSmallScreen
                            ? screenWidth * 0.105
                            : screenWidth * 0.127,
                        width: isSmallScreen
                            ? screenWidth * 0.105
                            : screenWidth * 0.127,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                width: isSmallScreen ? screenWidth * 0.14 : screenWidth * 0.165,
                bottom: screenHeight * 0.267,
                right:
                    isSmallScreen ? screenWidth * 0.1775 : screenWidth * 0.1125,
                child: ButtonCommonStyle(
                  onPressed: () {
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
                      borderRadius: BorderRadius.circular(isSmallScreen
                          ? screenWidth * 0.14
                          : screenWidth * 0.165),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(isSmallScreen
                          ? screenWidth * 0.14
                          : screenWidth * 0.165),
                      child: CachedNetworkImage(
                        imageUrl: instagrammableProvider.picture3,
                        fadeInDuration: const Duration(milliseconds: 100),
                        height: isSmallScreen
                            ? screenWidth * 0.14
                            : screenWidth * 0.165,
                        width: isSmallScreen
                            ? screenWidth * 0.14
                            : screenWidth * 0.165,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                width:
                    isSmallScreen ? screenWidth * 0.13 : screenWidth * 0.1575,
                bottom: screenHeight * 0.305,
                left:
                    isSmallScreen ? screenWidth * 0.1725 : screenWidth * 0.103,
                child: ButtonCommonStyle(
                  onPressed: () {
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
                      borderRadius: BorderRadius.circular(isSmallScreen
                          ? screenWidth * 0.13
                          : screenWidth * 0.1575),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(isSmallScreen
                          ? screenWidth * 0.13
                          : screenWidth * 0.1575),
                      child: CachedNetworkImage(
                        imageUrl: instagrammableProvider.picture4,
                        fadeInDuration: const Duration(milliseconds: 100),
                        height: isSmallScreen
                            ? screenWidth * 0.13
                            : screenWidth * 0.1575,
                        width: isSmallScreen
                            ? screenWidth * 0.13
                            : screenWidth * 0.1575,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                width: isSmallScreen ? screenWidth * 0.145 : screenWidth * 0.18,
                bottom: screenHeight * 0.375,
                right: isSmallScreen ? screenWidth * 0.445 : screenWidth * 0.43,
                child: ButtonCommonStyle(
                  onPressed: () {
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
                      borderRadius: BorderRadius.circular(isSmallScreen
                          ? screenWidth * 0.145
                          : screenWidth * 0.18),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(isSmallScreen
                          ? screenWidth * 0.145
                          : screenWidth * 0.18),
                      child: CachedNetworkImage(
                        imageUrl: instagrammableProvider.picture5,
                        fadeInDuration: const Duration(milliseconds: 100),
                        height: isSmallScreen
                            ? screenWidth * 0.145
                            : screenWidth * 0.18,
                        width: isSmallScreen
                            ? screenWidth * 0.145
                            : screenWidth * 0.18,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                width: isSmallScreen ? screenWidth * 0.155 : screenWidth * 0.17,
                bottom:
                    isSmallScreen ? screenHeight * 0.43 : screenHeight * 0.445,
                right: screenWidth * 0.435,
                child: SvgPicture.asset(
                  'assets/icons/crown.svg',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
