import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/widgets/texts/gu_text_body.dart';
import 'package:groupup/core/widgets/texts/gu_text_header.dart';
import 'package:groupup/screens/individual_group/components/instagrammable/components/choose_participant_profile_picture.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum SetPictureType {
  picture1,
  picture2,
  picture3,
  picture4,
  picture5,
  picture6
}

class InstagrammableProvider extends ChangeNotifier {
  var picture1 = '';
  var picture2 = '';
  var picture3 = '';
  var picture4 = '';
  var picture5 = '';
  var picture6 =
      'https://firebasestorage.googleapis.com/v0/b/groupup-432b8.appspot.com/o/transparent.png?alt=media&token=3bfa8b09-00e6-44eb-8b93-2889f5dd5759';
  final screenshotController = ScreenshotController();

  void setPlaceholderImages(String currentUserPicture) {
    const placholderImage =
        'https://firebasestorage.googleapis.com/v0/b/groupup-432b8.appspot.com/o/picture.png?alt=media&token=7707d961-1680-4575-bcf2-89b5e5b93bad';
    picture1 =
        currentUserPicture.isEmpty ? placholderImage : currentUserPicture;
    picture2 =
        currentUserPicture.isEmpty ? placholderImage : currentUserPicture;
    picture3 =
        currentUserPicture.isEmpty ? placholderImage : currentUserPicture;
    picture4 =
        currentUserPicture.isEmpty ? placholderImage : currentUserPicture;
    picture5 =
        currentUserPicture.isEmpty ? placholderImage : currentUserPicture;
    notifyListeners();
  }

  void setPicture(String picture, SetPictureType pictureType) {
    switch (pictureType) {
      case SetPictureType.picture1:
        picture1 = picture;
        break;
      case SetPictureType.picture2:
        picture2 = picture;
        break;
      case SetPictureType.picture3:
        picture3 = picture;
        break;
      case SetPictureType.picture4:
        picture4 = picture;
        break;
      case SetPictureType.picture5:
        picture5 = picture;
        break;
      case SetPictureType.picture6:
        break;
    }
    notifyListeners();
  }

  void choosePicture(BuildContext context, SetPictureType pictureType) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        final appLocalizations = AppLocalizations.of(context);
        final group = Provider.of<IndividualGroupProvider>(context).group;
        if (group == null) return const SizedBox();
        return AlertDialog(
          title: GUTextHeader(
            text: appLocalizations.choosePicture,
            textAlign: TextAlign.center,
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
                  padding:
                      const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                  separatorBuilder: (context, index) => const Divider(
                    indent: kDefaultPadding,
                    endIndent: kDefaultPadding,
                    height: 20,
                    thickness: 0.5,
                    color: GPColors.secondaryColor,
                  ),
                  itemCount: group.participantsData.length,
                  itemBuilder: (context, index) =>
                      ChooseParticipantProfilePicture(
                    participant: group.participantsData[index],
                    pictureType: pictureType,
                  ),
                ),
                ButtonCommonStyle(
                  onPressed: () {
                    Provider.of<MixPanelProvider>(context, listen: false)
                        .logEvent(
                            eventName: 'Choose Picture Instagrammable - None');
                    setPicture(picture6, pictureType);
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: Container(
                      height: 50,
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: GPColors.secondaryColor,
                            width: 0.5,
                          ),
                          bottom: BorderSide(
                            color: GPColors.secondaryColor,
                            width: 0.5,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GUTextBody(text: appLocalizations.none),
                        ],
                      ),
                    ),
                  ),
                )
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
                  Provider.of<MixPanelProvider>(context, listen: false)
                      .logEvent(
                          eventName: 'Choose Picture Instagrammable - OK');
                  Navigator.of(context).pop();
                },
                child: const GUTextHeader(
                  text: 'OK',
                  color: GPColors.primaryColor,
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
