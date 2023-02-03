import 'dart:io';

import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/core/providers/instagrammable_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class ShareInstagrammableButton extends StatelessWidget {
  const ShareInstagrammableButton({super.key});

  @override
  Widget build(BuildContext context) {
    final individualGroupProvider =
        Provider.of<IndividualGroupProvider>(context);
    if (individualGroupProvider.group == null) {
      return const CircularProgressIndicator(color: kPrimaryColor);
    }
    return SizedBox(
      height: 75,
      width: 75,
      child: FittedBox(
        child: FloatingActionButton(
          heroTag: 'btn10',
          onPressed: () async {
            final screenshotController =
                Provider.of<InstagrammableProvider>(context, listen: false)
                    .screenshotController;
            final imageFile = await screenshotController.capture();
            final directory = await getApplicationDocumentsDirectory();
            final image = await File('${directory.path}/image.png').create();
            if (imageFile == null) {
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
