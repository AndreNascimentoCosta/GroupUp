import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/participant.dart';
import 'package:groupup/models/user_input_data.dart';
import 'package:provider/provider.dart';
import 'package:story_view/story_view.dart';

class StoryWidget extends StatelessWidget {
  StoryWidget({
    required this.inputDatas,
    required this.participant,
  }) {
    addStoryItems();
  }

  final List<UserInputData> inputDatas;
  final Participant participant;
  final storyItems = <StoryItem>[];
  final controller = StoryController();

  void addStoryItems() {
    for (final inputData in inputDatas.reversed) {
      final image = inputData.image;
      if (image == null) return;
      storyItems.add(
        StoryItem.pageImage(
          url: image,
          controller: controller,
          duration: const Duration(seconds: 20),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUserName = Provider.of<AuthProvider>(context).user?.name;
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: StoryView(
                storyItems: storyItems,
                controller: controller,
                onComplete: Navigator.of(context).pop,
                onVerticalSwipeComplete: (direction) {
                  if (direction == Direction.down) {
                    Navigator.of(context).pop();
                  }
                },
              ),
            ),
            Container(
              height: 180,
              color: Colors.white,
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 70, left: 20),
          child: Material(
            type: MaterialType.transparency,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(Insets.l * 5),
                  child: CachedNetworkImage(
                    imageUrl: participant.profilePicture,
                    fadeInDuration: const Duration(milliseconds: 100),
                    height: Insets.l * 2.5,
                    width: Insets.l * 2.5,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: Insets.m),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: StaticText(
                    text: participant.name == currentUserName
                        ? 'Me'
                        : participant.name,
                    fontSize: TextSize.lBody,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
