import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
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
    final participantsData =
        Provider.of<IndividualGroupProvider>(context).group!.participantsData;
    final instagrammableProvider = Provider.of<InstagrammableProvider>(context);
    final participantData = participantsData[0];
    return Screenshot(
      controller: instagrammableProvider.screenshotController,
      child: Scaffold(
        appBar: const AppBarInstagrammable(),
        body: SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              SvgPicture.asset(
                'assets/images/instagrammable.svg',
              ),
              Positioned(
                width: MediaQuery.of(context).size.width * 0.145,
                bottom: MediaQuery.of(context).size.height * 0.585,
                left: MediaQuery.of(context).size.width * 0.165,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.145),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.145),
                    child: CachedNetworkImage(
                      imageUrl: participantData.profilePicture,
                      fadeInDuration: const Duration(milliseconds: 100),
                      height: MediaQuery.of(context).size.width * 0.145,
                      width: MediaQuery.of(context).size.width * 0.145,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                width: MediaQuery.of(context).size.width * 0.127,
                bottom: MediaQuery.of(context).size.height * 0.575,
                right: MediaQuery.of(context).size.width * 0.1415,
                child: ButtonCommonStyle(
                  onPressed: () {
                    Provider.of<InstagrammableProvider>(context, listen: false)
                        .choosePicture(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.127),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.127),
                      child: CachedNetworkImage(
                        imageUrl: participantData.profilePicture,
                        height: MediaQuery.of(context).size.width * 0.127,
                        width: MediaQuery.of(context).size.width * 0.127,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                width: MediaQuery.of(context).size.width * 0.165,
                bottom: MediaQuery.of(context).size.width * 0.58,
                right: MediaQuery.of(context).size.width * 0.1125,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.165),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.165),
                    child: CachedNetworkImage(
                      imageUrl: participantData.profilePicture,
                      fadeInDuration: const Duration(milliseconds: 100),
                      height: MediaQuery.of(context).size.width * 0.165,
                      width: MediaQuery.of(context).size.width * 0.165,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                width: MediaQuery.of(context).size.width * 0.1575,
                bottom: MediaQuery.of(context).size.width * 0.6625,
                left: MediaQuery.of(context).size.width * 0.103,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.1575),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.1575),
                    child: CachedNetworkImage(
                      imageUrl: participantData.profilePicture,
                      fadeInDuration: const Duration(milliseconds: 100),
                      height: MediaQuery.of(context).size.width * 0.1575,
                      width: MediaQuery.of(context).size.width * 0.1575,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                width: MediaQuery.of(context).size.width * 0.18,
                bottom: MediaQuery.of(context).size.width * 0.82,
                right: MediaQuery.of(context).size.width * 0.43,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.1725),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.1725),
                    child: CachedNetworkImage(
                      imageUrl: participantData.profilePicture,
                      fadeInDuration: const Duration(milliseconds: 100),
                      height: MediaQuery.of(context).size.width * 0.1725,
                      width: MediaQuery.of(context).size.width * 0.1725,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                width: MediaQuery.of(context).size.width * 0.17,
                bottom: MediaQuery.of(context).size.width * 0.96,
                right: MediaQuery.of(context).size.width * 0.43,
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
