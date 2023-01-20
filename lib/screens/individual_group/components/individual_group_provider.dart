import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:groupup/models/group_model.dart';

class IndividualGroupProvider extends ChangeNotifier {
  GroupModel? group;

  Future<void> getGroup(String groupId) async {
    group = null;
    notifyListeners();
    final groupDocument = await FirebaseFirestore.instance
        .collection('groups')
        .doc(groupId)
        .get();

    final docId = groupDocument.id;
    final docData = groupDocument.data();
    if (docData == null) return;
    group = GroupModel.fromMap(docId, docData);
    notifyListeners();
  }
}
