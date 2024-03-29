import 'dart:io';

import 'package:flutter/material.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/widgets/loading/gp_loading.dart';
import 'package:groupup/modules/individual_group/components/individual_group_events.dart';
import 'package:groupup/modules/individual_group/components/instagrammable/components/instagrammable_body.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class ShareInstagrammableButton extends StatelessWidget {
  const ShareInstagrammableButton({super.key});

  @override
  Widget build(BuildContext context) {
    final screenshotController = ScreenshotController();
    final isAndroidScreen = context.screenHeight > 820 &&
        context.screenHeight < 821 &&
        context.screenWidth < 412;
    final individualGroupProvider =
        Provider.of<IndividualGroupProvider>(context);
    if (individualGroupProvider.group == null) {
      return const GPLoading();
    }
    return SizedBox(
      height: 75,
      width: 75,
      child: FittedBox(
        child: FloatingActionButton(
          heroTag: 'btn10',
          onPressed: () async {
            Provider.of<MixPanelProvider>(context, listen: false).logEvent(
              eventName: IndividualGroupEvents.shareInstagrammable.value,
            );
            final size = context.screenSize;
            final imageFile = await screenshotController.captureFromWidget(
              ChangeNotifierProvider(
                create: (context) => AuthProvider(),
                child: const InstagrammableBody(
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
          backgroundColor: GPColors.primaryColor,
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
