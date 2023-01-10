import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/create_group_model.dart';
import 'package:groupup/models/home_view.dart';
import 'package:groupup/models/participant.dart';
import 'package:groupup/models/switch.dart';
import 'package:groupup/screens/groups/screens/groups_screen.dart';
import 'package:groupup/screens/home/components/bottom_sheet/create/components/date_switch.dart';
import 'package:groupup/screens/home/components/bottom_sheet/sign_up/auth_provider.dart';
import 'package:groupup/screens/home/components/next_button.dart';
import 'package:provider/provider.dart';

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
  File? image;
  final DateSwitch dateSwitch = DateSwitch(switchModel: SwitchModel());
  final users = [];
  bool isCreatingGroup = false;

  final newGroup = CreateGroupModel.empty();

  CreateGroupProvider() {
    controllerProjectName.addListener(notifyListeners);
    controllerObjective.addListener(notifyListeners);
    controllerReward.addListener(notifyListeners);
    controllerNumberParticipants.addListener(notifyListeners);
    controllerStartDate.addListener(notifyListeners);
    controllerEndDate.addListener(notifyListeners);
    dateSwitch.switchModel.isSwitched.addListener(notifyListeners);
  }

  void _confirm(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const StaticText(
            text: 'Confirm',
            textAlign: TextAlign.center,
            fontFamily: 'Montserrat-SemiBold',
            fontSize: TextSize.lBody,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: const StaticText(
            text: 'Are you sure you want to create a \ngroup?',
            maxLines: 2,
            textAlign: TextAlign.center,
            fontSize: TextSize.mBody,
          ),
          actionsAlignment: MainAxisAlignment.center,
          contentPadding: const EdgeInsets.only(top: 20, bottom: 20),
          actions: [
            NextButton(
              text: 'No',
              textColor: Colors.red,
              borderColor: Colors.transparent,
              onPressed: () => Navigator.of(context).pop(),
              color: Colors.transparent,
              height: 40,
              width: 140,
            ),
            NextButton(
              text: 'Yes',
              borderColor: kPrimaryColor,
              onPressed: () => createGroup(context),
              height: 40,
              width: 140,
            ),
          ],
        );
      },
    );
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
            rewardText.isEmpty ||
            (double.tryParse(rewardText) ?? 0) <= 0.0)) {
      return null;
    } else if (pageIndex == 1 &&
        (noParticipantsText.isEmpty ||
                (int.tryParse(noParticipantsText) ?? 0) > 50 ||
                dateSwitch.switchModel.isSwitched.value
            ? startDateText.isNotEmpty && endDateText.isNotEmpty
            : startDateText.isEmpty && endDateText.isEmpty)) {
      return null;
    } else if (pageIndex == 2) {
      return () {
        Navigator.of(context).pushAndRemoveUntil(
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => GroupsScreen(
              homeViewModel: HomeViewModel(),
            ),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
          (route) => false,
        );
      };
    } else {
      return () => {
            FocusNode().unfocus(),
            if (pageIndex == 0)
              {
                controller.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                ),
              }
            else
              {
                _confirm(context),
              }
          };
    }
  }

  void updateIndex(int index) {
    pageIndex = index;
    notifyListeners();
  }

  String generateRandomString(int len) {
    var r = Random();
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
    return List.generate(len, (index) => chars[r.nextInt(chars.length)]).join();
  }

  Future<String> generateGroupCode() async {
    final groupCode = generateRandomString(6);
    final groupCodeExists = await FirebaseFirestore.instance
        .collection('groups')
        .where('groupCode', isEqualTo: groupCode)
        .get();
    if (groupCodeExists.docs.isNotEmpty) {
      return generateGroupCode();
    } else {
      return groupCode;
    }
  }

  Future<void> createGroup(BuildContext context) async {
    controller.jumpToPage(3);
    Navigator.pop(context);
    isCreatingGroup = true;
    notifyListeners();
    newGroup.projectName = controllerProjectName.text;
    newGroup.objective = controllerObjective.text;
    newGroup.reward = controllerReward.text;
    newGroup.maxParticipants =
        int.tryParse(controllerNumberParticipants.text) ?? 0;

    final user = Provider.of<AuthProvider>(context, listen: false).user;
    final userParticipant = Participant(
      uid: user.uid,
      name: user.displayName ?? '',
      profilePicture: '',
      inputData: [],
      isAdmin: true,
    );

    final groupCode = await generateGroupCode();
    newGroup.groupCode = groupCode;
    newGroup.participants.add(user.uid);
    newGroup.participantsData.add(userParticipant);

    final image = this.image;
    if (image != null) {
      try {
        final userId = user.uid;
        final fileExtension = image.path.split('.').last;
        final result = await FirebaseStorage.instance
            .ref()
            .child(userId)
            .child("profileImage.$fileExtension")
            .putFile(image);
        final url = await result.ref.getDownloadURL();
        newGroup.image = url;
      } on FirebaseException {
        // ignore: avoid_print
        print("Deu ruim");
      }
    }
    //
    await FirebaseFirestore.instance
        .collection('groups')
        .doc()
        .set(newGroup.toMap());
    isCreatingGroup = false;
    notifyListeners();
  }

  /// Call this every time when openning bottom sheet for creating group
  void clean() {
    controllerProjectName.clear();
    controllerObjective.clear();
    controllerReward.clear();
    controllerNumberParticipants.clear();
    controllerStartDate.clear();
    controllerEndDate.clear();
    newGroup.projectName = '';
    newGroup.objective = '';
    newGroup.reward = '';
    image = null;
    newGroup.maxParticipants = 0;
    newGroup.allowEditImage = false;
    newGroup.allowRefundRequest = false;
    newGroup.startDate = null;
    newGroup.endDate = null;
    updateIndex(0);
    notifyListeners();
  }
}
