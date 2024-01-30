import 'package:flutter/material.dart';
import 'package:groupup/models/participant.dart';
import 'package:groupup/modules/individual_group/components/story_widget.dart';

import '../../../models/user_input_data.dart';

class StoryPage extends StatelessWidget {
  const StoryPage({
    required this.inputDatas,
    required this.participant,
  });

  final List<UserInputData> inputDatas;
  final Participant participant;

  @override
  Widget build(BuildContext context) {
    return StoryWidget(
      inputDatas: inputDatas
          .where(
            (element) =>
                element.image != null &&
                (element.date).isAfter(
                  DateTime.now().subtract(
                        const Duration(days: 1),
                      ),
                ),
          )
          .toList(),
      participant: participant,
    );
  }
}
