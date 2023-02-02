import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/individual_group/components/instagrammable/components/choose_participant_profile_picture.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../widgets/texts/static_text.dart';

class InstagrammableProvider extends ChangeNotifier {
  var picture = '';
  final screenshotController = ScreenshotController();

  void takeScreenshot() async {
    final imageFile = await screenshotController.capture();
    if (imageFile == null) return;
    Share.shareXFiles(
      [
        XFile(
          imageFile.toString(),
        ),
      ],
    );
  }

  void choosePicture(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        final group = Provider.of<IndividualGroupProvider>(context).group;
        if (group == null) return const SizedBox();
        return AlertDialog(
          title: const StaticText(
            text: 'Choose a picture',
            textAlign: TextAlign.center,
            fontFamily: 'Montserrat-SemiBold',
            fontSize: TextSize.lBody,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => const Divider(
                    indent: kDefaultPadding,
                    endIndent: kDefaultPadding,
                    height: 20,
                    thickness: 0.5,
                    color: kSecondaryColor,
                  ),
                  itemCount: group.participantsData.length,
                  itemBuilder: (context, index) =>
                      ChooseParticipantProfilePicture(
                    participant: group.participantsData[index],
                  ),
                ),
              ],
            ),
          ),
          contentPadding: const EdgeInsets.only(bottom: 20),
          actionsAlignment: MainAxisAlignment.center,
          actionsPadding: const EdgeInsets.only(bottom: 15),
          actions: [
            SizedBox(
              width: double.infinity,
              child: ButtonCommonStyle(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const StaticText(
                  text: 'OK',
                  fontSize: TextSize.mBody,
                  fontFamily: 'Montserrat-SemiBold',
                  color: kPrimaryColor,
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
