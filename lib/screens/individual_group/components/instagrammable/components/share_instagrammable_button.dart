import 'dart:io';

import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/core/providers/instagrammable_provider.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/screens/individual_group/components/instagrammable/components/body_instagrammable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class ShareInstagrammableButton extends StatelessWidget {
  const ShareInstagrammableButton({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = context.screenHeight;
    final screenWidth = context.screenWidth;
    final isAndroidScreen =
        screenHeight > 820 && screenHeight < 821 && screenWidth < 412;
    final individualGroupProvider =
        Provider.of<IndividualGroupProvider>(context);
    if (individualGroupProvider.group == null) {
      return const CircularProgressIndicator.adaptive();
    }
    return SizedBox(
      height: 75,
      width: 75,
      child: FittedBox(
        child: FloatingActionButton(
          heroTag: 'btn10',
          onPressed: () async {
            Provider.of<MixPanelProvider>(context, listen: false)
                .logEvent(eventName: 'Share Instagrammable');
            final screenshotController =
                Provider.of<InstagrammableProvider>(context, listen: false)
                    .screenshotController;
            final size = context.screenSize;
            final imageFile = await screenshotController.captureFromWidget(
              MultiProvider(
                providers: [
                  ListenableProvider(
                    create: (_) => Provider.of<AuthProvider>(
                      context,
                      listen: false,
                    ),
                  ),
                  ListenableProvider(
                    create: (_) => Provider.of<InstagrammableProvider>(
                      context,
                      listen: false,
                    ),
                  ),
                ],
                child: const BodyInstagrammable(
                  isSharing: true,
                ),
              ),
              pixelRatio: 3.0,
              targetSize: Size(
                isAndroidScreen ? size.width - size.width * 0.13 : size.width,
                size.height - size.height * 0.3,
              ),
              context: context,
            );
            final directory = await getApplicationDocumentsDirectory();
            final image = await File('${directory.path}/image.png').create();
            if (imageFile.isEmpty) {
              return;
            }
            await image.writeAsBytes(imageFile);

            await Share.shareXFiles(
              [
                XFile(
                  image.path,
                ),
              ],
            );
          },
          backgroundColor: kPrimaryColor,
          highlightElevation: 0,
          elevation: 0,
          child: const Icon(
            Icons.share,
            size: 30,
          ),
        ),
      ),
    );
  }
}
