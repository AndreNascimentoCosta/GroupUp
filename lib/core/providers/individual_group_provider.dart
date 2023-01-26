import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:groupup/models/group_model.dart';

class IndividualGroupProvider extends ChangeNotifier {
  GroupModel? group;
  final pageController = PageController(initialPage: 0);
  int pageIndex = 0;

  void updateIndex(int index) {
    pageIndex = index;
    notifyListeners();
  }

  Future<void> getGroup(
    String groupId, {
    bool reset = true,
  }) async {
    if (reset) {
      group = null;
      notifyListeners();
    }
    final groupDocument = await FirebaseFirestore.instance
        .collection('groups')
        .doc(groupId)
        .get();

    final docId = groupDocument.id;
    final docData = groupDocument.data();
    if (docData == null) return;
    group = GroupModel.fromMap(docId, docData);
    group?.participantsData.sort(
      (a, b) => a.sumData.value > b.sumData.value ? -1 : 1,
    );
    notifyListeners();
  }
}
