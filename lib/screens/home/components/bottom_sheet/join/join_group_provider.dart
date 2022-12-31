import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:groupup/models/join_group_model.dart';

class JoinGroupProvider extends ChangeNotifier {
  final controllerGroupCode = TextEditingController();

  final controller = PageController();
  int pageIndex = 0;

  final joinGroup = JoinGroupModel(
    groupCode: '',
  );

  JoinGroupProvider() {
    controllerGroupCode.addListener(notifyListeners);
  }

  void Function()? nextPressed(BuildContext context) {
    // Index 0
    final joinGroupText = controllerGroupCode.text;

    if (pageIndex == 0 &&
        (joinGroupText.length < 3)) {
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
    joinGroup.groupCode = controllerGroupCode.text;
    final Map<String, dynamic> groupMap = {
      'groupCode': joinGroup.groupCode,
    };
    FirebaseFirestore.instance.collection('groups').doc().set(groupMap);
  }
}
