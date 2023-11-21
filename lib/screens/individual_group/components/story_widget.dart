import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:groupup/core/providers/add_input_provider.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/core/constants/design-system.dart';
import 'package:groupup/models/participant.dart';
import 'package:groupup/models/user_input_data.dart';
import 'package:provider/provider.dart';
import 'package:story/story.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/providers/mix_panel_provider.dart';

class StoryWidget extends StatelessWidget {
  const StoryWidget({
    required this.inputDatas,
    required this.participant,
  });

  final List<UserInputData> inputDatas;
  final Participant participant;

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<AuthProvider>(context).user;
    final appLocalizations = AppLocalizations.of(context)!;
    const placeholderProfilePicture =
        'https://firebasestorage.googleapis.com/v0/b/groupup-432b8.appspot.com/o/picture.png?alt=media&token=7707d961-1680-4575-9b0e-8c8c0c8c0c8c';
    if (currentUser == null) {
      return const SizedBox();
    }
    final group = Provider.of<IndividualGroupProvider>(
      context,
      listen: false,
    ).group;
    if (group == null) {
      return const SizedBox();
    }
    return StoryPageView(
      storyLength: (pageIndex) => inputDatas.length,
      pageLength: 1,
      indicatorDuration: const Duration(seconds: 10),
      indicatorPadding: const EdgeInsets.only(top: 60),
      itemBuilder: (context, pageIndex, storyIndex) {
        final inputData = inputDatas[storyIndex];
        return Stack(
          children: [
            Positioned.fill(
              child: Container(
                color: GPColors.black,
              ),
            ),
            Positioned.fill(
              child: StoryImage(
                key: ValueKey(
                  inputData.image!,
                ),
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Container(
                    color: GPColors.black,
                    child: const Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  );
                },
                imageProvider: NetworkImage(
                  inputData.image!,
                ),
                fit: BoxFit.contain,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: GPColors.black.withOpacity(0.025),
                    blurRadius: 10,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 80, left: 20),
                child: Material(
                  type: MaterialType.transparency,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (participant.profilePicture.isEmpty)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(Insets.l * 2),
                          child: Container(
                            height: Insets.l * 2,
                            width: Insets.l * 2,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                  placeholderProfilePicture,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )
                      else
                        ClipRRect(
                          borderRadius: BorderRadius.circular(Insets.l * 2),
                          child: Container(
                            height: Insets.l * 2,
                            width: Insets.l * 2,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                  participant.profilePicture,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      const SizedBox(width: Insets.m),
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: GPColors.black.withOpacity(0.15),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: StaticText(
                          text: participant.name == currentUser.name
                              ? appLocalizations.me
                              : participant.name,
                          fontSize: TextSize.lBody,
                          color: GPColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
      gestureItemBuilder: (context, pageIndex, storyIndex) {
        final inputData = inputDatas[storyIndex];
        final userAlreadyValidated = inputData.isValidated?.containsKey(
          currentUser.id,
        );
        if (userAlreadyValidated == true) {
          return const SizedBox();
        }
        if (participant.uid == currentUser.id) {
          return const SizedBox();
        }
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 75, horizontal: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: GPColors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: SizedBox(
                  height: 75,
                  width: 75,
                  child: FittedBox(
                    child: FloatingActionButton(
                      heroTag: 'btn7',
                      highlightElevation: 0,
                      onPressed: () {
                        Provider.of<MixPanelProvider>(context, listen: false)
                            .logEvent(eventName: 'Data invalidated');
                        Provider.of<AddInputProvider>(
                          context,
                          listen: false,
                        ).dataValidationNo(
                          context,
                          group.id,
                          inputData.date,
                          inputData.value,
                          inputData.image!,
                          participant.uid,
                        );
                        Navigator.of(context).pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: StaticText(
                              text: appLocalizations.dataInvalidated,
                              textAlign: TextAlign.center,
                              fontSize: TextSize.mBody,
                              color: GPColors.white,
                            ),
                            duration: const Duration(seconds: 2),
                            backgroundColor: GPColors.secondaryColor,
                          ),
                        );
                      },
                      backgroundColor: GPColors.red,
                      elevation: 0,
                      child: const Icon(
                        Icons.close_rounded,
                        size: 35,
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: GPColors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: Insets.s),
                  child: Material(
                    type: MaterialType.transparency,
                    child: StaticText(
                      text: inputData.value.toString(),
                      fontSize: TextSize.title,
                      color: GPColors.white,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: GPColors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: SizedBox(
                  height: 75,
                  width: 75,
                  child: FittedBox(
                    child: FloatingActionButton(
                      heroTag: 'btn8',
                      highlightElevation: 0,
                      onPressed: () {
                        Provider.of<MixPanelProvider>(context, listen: false)
                            .logEvent(eventName: 'Data validated');
                        Provider.of<AddInputProvider>(
                          context,
                          listen: false,
                        ).dataValidationYes(
                          context,
                          group.id,
                          inputData.date,
                          inputData.value,
                          inputData.image!,
                          participant.uid,
                        );
                        Navigator.of(context).pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: StaticText(
                              text: appLocalizations.dataValidated,
                              textAlign: TextAlign.center,
                              fontSize: TextSize.mBody,
                              color: GPColors.white,
                            ),
                            duration: const Duration(seconds: 2),
                            backgroundColor: GPColors.secondaryColor,
                          ),
                        );
                      },
                      backgroundColor: GPColors.primaryColor,
                      elevation: 0,
                      child: const Icon(
                        Icons.check,
                        size: 35,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      onPageLimitReached: () {
        Navigator.pop(context);
      },
    );
  }
}
