import 'package:flutter/material.dart';
import 'package:groupup/screens/individual_group/components/story_widget.dart';

import '../../../models/user_input_data.dart';

class StoryPage extends StatelessWidget {
  const StoryPage({
    required this.inputDatas,
  });

  final List<UserInputData> inputDatas;

  @override
  Widget build(BuildContext context) {
    return StoryWidget(
      inputDatas: inputDatas,
    );
  }
}
