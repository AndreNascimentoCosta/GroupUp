import 'package:flutter/material.dart';
import 'package:groupup/models/user_input_data.dart';
import 'package:story_view/story_view.dart';

class StoryWidget extends StatelessWidget {
  StoryWidget({
    required this.inputDatas,
  }) {
    addStoryItems();
  }

  final List<UserInputData> inputDatas;
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
    return StoryView(
      storyItems: storyItems,
      controller: controller,
      onComplete: Navigator.of(context).pop,
      onVerticalSwipeComplete: (direction) {
        if (direction == Direction.down) {
          Navigator.of(context).pop();
        }
      },
    );
  }
}
