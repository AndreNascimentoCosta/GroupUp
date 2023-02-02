import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/core/providers/instagrammable_provider.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/design-system.dart';
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
    final participantsData =
        Provider.of<IndividualGroupProvider>(context).group!.participantsData;
    final instagrammableProvider = Provider.of<InstagrammableProvider>(context);
    final participantData = participantsData[0];
    return Screenshot(
      controller: instagrammableProvider.screenshotController,
      child: Scaffold(
        appBar: const AppBarInstagrammable(),
        body: Stack(
          children: [
            SvgPicture.asset(
              'assets/images/instagrammable.svg',
            ),
            Positioned(
              width: Insets.l * 3,
              bottom: 555,
              left: 66,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(Insets.l * 3),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Insets.l * 3),
                  child: CachedNetworkImage(
                    imageUrl: participantData.profilePicture,
                    fadeInDuration: const Duration(milliseconds: 100),
                    height: Insets.l * 3,
                    width: Insets.l * 3,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              width: Insets.l * 2.7,
              bottom: 546,
              right: 54,
              child: ButtonCommonStyle(
                onPressed: () {
                  Provider.of<InstagrammableProvider>(context, listen: false)
                      .choosePicture(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(Insets.l * 2.7),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(Insets.l * 2.7),
                    child: CachedNetworkImage(
                      imageUrl: participantData.profilePicture,
                      height: Insets.l * 2.7,
                      width: Insets.l * 2.7,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              width: Insets.l * 3.5,
              bottom: 260,
              right: 42,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(Insets.l * 3.5),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Insets.l * 3.5),
                  child: CachedNetworkImage(
                    imageUrl: participantData.profilePicture,
                    fadeInDuration: const Duration(milliseconds: 100),
                    height: Insets.l * 3.5,
                    width: Insets.l * 3.5,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              width: Insets.l * 3.5,
              bottom: 295,
              left: 37,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(Insets.l * 3.5),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Insets.l * 3.5),
                  child: CachedNetworkImage(
                    imageUrl: participantData.profilePicture,
                    fadeInDuration: const Duration(milliseconds: 100),
                    height: Insets.l * 3.5,
                    width: Insets.l * 3.5,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              width: Insets.l * 3.85,
              bottom: 362,
              right: 178,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(Insets.l * 3.85),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Insets.l * 3.85),
                  child: CachedNetworkImage(
                    imageUrl: participantData.profilePicture,
                    fadeInDuration: const Duration(milliseconds: 100),
                    height: Insets.l * 3.85,
                    width: Insets.l * 3.85,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              width: Insets.l * 3.85,
              bottom: 425,
              right: 178,
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
