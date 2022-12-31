import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:groupup/models/create_group_model.dart';
import 'package:groupup/models/home_view.dart';
import 'package:groupup/screens/groups/screens/groups_screen.dart';

class CreateGroupProvider extends ChangeNotifier {
  final controllerProjectName = TextEditingController();
  final controllerObjective = TextEditingController();
  final controllerReward = TextEditingController();
  final controllerNumberParticipants = TextEditingController();
  final controllerStartDate = TextEditingController();
  final controllerEndDate = TextEditingController();

  final controller = PageController(initialPage: 0);
  final itemCount = 3;
  int pageIndex = 0;

  final newGroup = CreateGroupModel(
    projectName: '',
    objective: '',
    reward: '',
    noParticipants: 0,
    allowEditImage: false,
    allowRefundRequest: false,
  );

  CreateGroupProvider() {
    controllerProjectName.addListener(notifyListeners);
    controllerObjective.addListener(notifyListeners);
    controllerReward.addListener(notifyListeners);
    controllerNumberParticipants.addListener(notifyListeners);
    controllerStartDate.addListener(notifyListeners);
    controllerEndDate.addListener(notifyListeners);
  }

  void Function()? nextPressed(BuildContext context) {
    // Index 0
    final projectNameText = controllerProjectName.text;
    final objectiveText = controllerObjective.text;
    final rewardText = controllerReward.text;
    final startDateText = controllerStartDate.text;
    final endDateText = controllerEndDate.text;

    // Index 1
    final noParticipantsText = controllerNumberParticipants.text;

    if (pageIndex == 0 &&
        (projectNameText.length < 3 ||
            objectiveText.length < 3 ||
            rewardText.isEmpty)) {
      return null;
    } else if (pageIndex == 1 &&
        (noParticipantsText.isEmpty ||
            (int.tryParse(noParticipantsText) ?? 0) > 50 ||
            startDateText.isEmpty || endDateText.isEmpty)) {
      return null;
    } else if (pageIndex == 3) {
      return () {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => GroupsScreen(
              homeViewModel: HomeViewModel(),
            ),
          ),
          (route) => false,
        );
        CreateGroupProvider().createGroup();
      };
    } else {
      return () => {
            FocusNode().unfocus(),
            controller.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            ),
          };
    }
  }

  void updateIndex(int index) {
    pageIndex = index;
    notifyListeners();
  }

  Future<void> createGroup() async {
    newGroup.projectName = controllerProjectName.text;
    newGroup.objective = controllerObjective.text;
    newGroup.reward = controllerReward.text;
    newGroup.noParticipants =
        int.tryParse(controllerNumberParticipants.text) ?? 0;
    final Map<String, dynamic> groupMap = {
      'projectName': newGroup.projectName,
      'objective': newGroup.objective,
      'reward': newGroup.reward,
      'noParticipants': newGroup.noParticipants,
      'allowEditImage': newGroup.allowEditImage,
      'allowRefundRequest': newGroup.allowRefundRequest,
      'startDate': newGroup.startDate,
      'endDate': newGroup.endDate,
    };
    FirebaseFirestore.instance.collection('groups').doc().set(groupMap);
  }
}
