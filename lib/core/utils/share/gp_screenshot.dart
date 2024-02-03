import 'package:flutter/material.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/providers/instagrammable_provider.dart';
import 'package:groupup/modules/individual_group/components/instagrammable/components/instagrammable_body.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class GPScreenshot {
  Future<bool> captureAndShare({
    required Widget widget,
    required BuildContext context,
    required ScreenshotController screenshotController,
  }) async {
    final size = MediaQuery.of(context).size;
    final imageBytes = await screenshotController.captureFromWidget(
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
        child: const InstagrammableBody(
          isSharing: true,
        ),
      ),
      pixelRatio: 3.0,
      targetSize: Size(
        context.isAndroidScreen ? size.width - size.width * 0.13 : size.width,
        size.height - size.height * 0.3,
      ),
      context: context,
    );
    final result = await Share.shareXFiles([
      XFile.fromData(
        imageBytes,
        name: 'foodby',
        mimeType: 'png',
      ),
    ]);
    return result.status == ShareResultStatus.success;
  }
}
