import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/models/group_model.dart';
import 'package:provider/provider.dart';

class IndividualGroupProvider extends ChangeNotifier {
  GroupModel? group;
  final pageController = PageController(initialPage: 0);
  int pageIndex = 0;
  bool isClaimingReward = false;

  void updateIndex(int index) {
    pageIndex = index;
    notifyListeners();
  }

  void updateAllowGroupPicture(bool value) {
    group?.allowEditImage = value;
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

  Future<void> claimReward(
    BuildContext context,
    String currentUserId,
    String groupId,
  ) async {
    final navigatorState = Navigator.of(context);
    Provider.of<MixPanelProvider>(context, listen: false)
        .logEvent(eventName: 'Group Ended Dialog Claim Reward');
    isClaimingReward = true;
    notifyListeners();
    await FirebaseFunctions.instance
        .httpsCallable('AddGroupRewardToUserBalance')
        .call(
      {
        'userId': currentUserId,
        'groupId': groupId,
      },
    );
    isClaimingReward = false;
    notifyListeners();
    navigatorState.pop();
    navigatorState.pop();
  }
}
