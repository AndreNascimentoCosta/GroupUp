import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/extensions/gp_navigator_extension.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';
import 'package:groupup/core/widgets/texts/gp_text_header.dart';
import 'package:groupup/models/group_model.dart';
import 'package:groupup/models/home_view_model.dart';
import 'package:groupup/models/participant_model.dart';
import 'package:groupup/models/user_data_model.dart';
import 'package:groupup/modules/create_group_page_view/components/create_group_events.dart';
import 'package:groupup/modules/main_page_view/screens/main_page_view_screen.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/widgets/buttons/gp_button.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'mix_panel_provider.dart';

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
  String groupCurrencyCode = '';
  final users = [];
  bool isCreatingGroup = false;
  bool isRefundRequested = true;
  bool isPaying = false;

  final newGroup = GroupModel.empty();

  CreateGroupProvider() {
    controllerProjectName.addListener(notifyListeners);
    controllerObjective.addListener(notifyListeners);
    controllerReward.addListener(notifyListeners);
    controllerNumberParticipants.addListener(notifyListeners);
    controllerStartDate.addListener(notifyListeners);
    controllerEndDate.addListener(notifyListeners);
  }

  void _confirmCreateGroup(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    showCupertinoDialog(
      context: context,
      builder: (BuildContext newContext) {
        return AlertDialog(
          title: Text(
            appLocalizations.confirm,
            textAlign: TextAlign.center,
            style: const TextStyle(fontFamily: 'Montserrat-SemiBold'),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Text(
              appLocalizations.confirmCreateGroup,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Montserrat-Medium',
              ),
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          contentPadding: const EdgeInsets.only(top: 20, bottom: 20),
          actions: [
            GPButton(
              text: appLocalizations.no,
              textColor: GPColors.red,
              borderColor: GPColors.transparent,
              onPressed: () {
                Provider.of<MixPanelProvider>(context, listen: false).logEvent(
                  eventName:
                      CreateGroupEvents.pressCancelCreateGroupDialog.value,
                );
                context.pop();
              },
              color: GPColors.transparent,
              height: 40,
              width: context.isVerySmallScreen
                  ? 100
                  : context.isSmallScreen
                      ? 120
                      : 140,
            ),
            GPButton(
              text: appLocalizations.yes,
              borderColor: GPColors.primaryColor,
              onPressed: () async {
                final user =
                    Provider.of<AuthProvider>(context, listen: false).user;
                Provider.of<MixPanelProvider>(context, listen: false).logEvent(
                  eventName: CreateGroupEvents.confirmCreateGroup.value,
                );
                context.pop();
                await createGroup(user);
              },
              height: 40,
              width: context.isVerySmallScreen
                  ? 100
                  : context.isSmallScreen
                      ? 120
                      : 140,
            ),
          ],
        );
      },
    );
  }

  void Function()? nextPressedCreate(
    BuildContext context,
  ) {
    final projectNameText = controllerProjectName.text;
    final objectiveText = controllerObjective.text;
    final rewardText = controllerReward.text;
    final startDateText = controllerStartDate.text;
    final endDateText = controllerEndDate.text;

    final noParticipantsText = controllerNumberParticipants.text;

    if (pageIndex == 0 &&
        (projectNameText.length < 3 ||
            objectiveText.length < 3 ||
            projectNameText.length >= 20 ||
            objectiveText.length >= 50 ||
            rewardText.length < 3 ||
            rewardText.length >= 50)) {
      return null;
    } else if (pageIndex == 1 &&
        (noParticipantsText.isEmpty ||
            (int.tryParse(noParticipantsText) ?? 0) > 50 ||
            (int.tryParse(noParticipantsText) ?? 0) == 0 ||
            startDateText.isEmpty ||
            endDateText.isEmpty ||
            newGroup.endDate == null ||
            newGroup.startDate == null ||
            newGroup.endDate!.isBefore(
              newGroup.startDate!,
            ))) {
      return null;
    } else if (pageIndex == 3) {
      return () {
        Provider.of<MixPanelProvider>(context, listen: false).logEvent(
          eventName: CreateGroupEvents.pressCreateGroupSuccessDialog.value,
        );
        context.pushAndRemoveUntil(
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                MainPageViewScreen(
              homeViewModel: HomeViewModel(),
            ),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
      };
    } else {
      return () => {
            Provider.of<MixPanelProvider>(context, listen: false).logEvent(
              eventName: CreateGroupEvents.pressNextButtonCreateGroup.value,
            ),
            FocusNode().unfocus(),
            if (pageIndex == 0 || pageIndex == 1)
              {
                controller.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                ),
              }
            else
              {
                Provider.of<MixPanelProvider>(context, listen: false).logEvent(
                  eventName: CreateGroupEvents.confirmCreateGroup.value,
                ),
                _confirmCreateGroup(context),
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

  Future<void> updateGroupImage(String imageFile, String groupId) async {
    final group = await FirebaseFirestore.instance
        .collection('groups')
        .doc(groupId)
        .get();
    if (group.exists) {
      final groupData = group.data();
      if (groupData != null) {
        await FirebaseFirestore.instance
            .collection('groups')
            .doc(groupId)
            .update({'image': imageFile});
      }
    }
  }

  Future<bool> updateAllowEditImage(
      BuildContext context, bool value, String groupId) async {
    final individualGroupProvider =
        Provider.of<IndividualGroupProvider>(context);
    Provider.of<IndividualGroupProvider>(context, listen: false)
        .updateAllowGroupPicture(value);
    final group = await FirebaseFirestore.instance
        .collection('groups')
        .doc(groupId)
        .get();
    if (group.exists) {
      final groupData = group.data();
      if (groupData != null) {
        final allowEditImage = groupData['allowEditImage'] as bool;
        if (allowEditImage != value) {
          await FirebaseFirestore.instance
              .collection('groups')
              .doc(groupId)
              .update({'allowEditImage': value});
          await individualGroupProvider.getGroup(groupId);
          return true;
        }
      }
    }
    return false;
  }

  Future<void> createGroup(UserDataModel? user) async {
    controller.jumpToPage(3);
    isCreatingGroup = true;
    notifyListeners();
    newGroup.projectName = controllerProjectName.text;
    newGroup.objective = controllerObjective.text;
    newGroup.reward = controllerReward.text;
    newGroup.maxParticipants =
        int.tryParse(controllerNumberParticipants.text) ?? 0;
    newGroup.groupCurrencyCode = groupCurrencyCode;

    final userId = FirebaseAuth.instance.currentUser!.uid;
    if (user == null) {
      return;
    }
    final userParticipant = Participant(
      uid: userId,
      name: user.name,
      profilePicture: user.profilePicture,
      inputData: [],
      isAdmin: true,
    );

    final groupCode = await generateGroupCode();
    newGroup.groupCode = groupCode;
    newGroup.creator = userId;
    newGroup.participants.add(userId);
    newGroup.participantsData.add(userParticipant);

    final image = this.image;
    if (image != null) {
      try {
        final fileExtension = image.path.split('.').last;
        final createdAt = Timestamp.now().nanoseconds;
        final result = await FirebaseStorage.instance
            .ref()
            .child(userId)
            .child("groupImage$createdAt.$fileExtension")
            .putFile(image);
        final url = await result.ref.getDownloadURL();
        newGroup.image = url;
      } on FirebaseException {
        debugPrint('Error uploading image');
      }
    }
    await FirebaseFirestore.instance
        .collection('groups')
        .doc()
        .set(newGroup.toMap());
    isCreatingGroup = false;
    notifyListeners();
  }

  void confirmExitGroup(BuildContext context, String groupId) {
    final appLocalizations = AppLocalizations.of(context)!;
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          width: double.infinity,
          child: AlertDialog(
            title: GPTextHeader(
              text: appLocalizations.confirm,
              textAlign: TextAlign.center,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: SingleChildScrollView(
                child: GPTextBody(
                  text: appLocalizations.confirmExitGroup,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            actionsAlignment: MainAxisAlignment.center,
            contentPadding: const EdgeInsets.only(top: 20, bottom: 20),
            actions: [
              GPButton(
                text: appLocalizations.no,
                textColor: GPColors.red,
                borderColor: GPColors.transparent,
                onPressed: () {
                  Provider.of<MixPanelProvider>(context, listen: false)
                      .logEvent(
                    eventName:
                        CreateGroupEvents.pressCancelLeaveGroupDialog.value,
                  );
                  isRefundRequested = true;
                  context.pop();
                },
                color: GPColors.transparent,
                height: 40,
                width: 140,
              ),
              GPButton(
                text: appLocalizations.yes,
                borderColor: GPColors.primaryColor,
                onPressed: () {
                  Provider.of<MixPanelProvider>(context, listen: false)
                      .logEvent(
                    eventName: CreateGroupEvents.pressLeaveGroup.value,
                  );
                  leaveGroup(context, groupId);
                  context.pop();
                  context.pop();
                  context.pop();
                },
                height: 40,
                width: 140,
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> leaveGroup(BuildContext context, String groupId) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final group = await FirebaseFirestore.instance
        .collection('groups')
        .doc(groupId)
        .get();
    if (group.exists) {
      final groupData = group.data();
      if (groupData != null) {
        final participants = groupData['participants'] as List<dynamic>;
        final participantsData = groupData['participantsData'] as List<dynamic>;
        final index = participants.indexOf(userId);
        if (index != -1) {
          final participantData =
              participantsData[index] as Map<String, dynamic>;
          final isAdmin = participantData['isAdmin'] as bool;
          if (isAdmin) {
            final newAdminId = participants.firstWhere(
              (element) => element != userId,
              orElse: () => '',
            );
            if (newAdminId != '') {
              final newAdminIndex = participants.indexOf(newAdminId);
              final newAdminData =
                  participantsData[newAdminIndex] as Map<String, dynamic>;
              final newAdmin = Participant.fromMap(newAdminData);
              newAdmin.isAdmin = true;
              participantsData[newAdminIndex] = newAdmin.toMap();
              participants.remove(userId);
              participantsData.removeAt(index);
              await FirebaseFirestore.instance
                  .collection('groups')
                  .doc(groupId)
                  .update({
                'participants': participants,
                'participantsData': participantsData,
              });
            } else {
              await FirebaseFirestore.instance
                  .collection('groups')
                  .doc(groupId)
                  .delete();
            }
          } else {
            participants.remove(userId);
            participantsData.removeAt(index);
            await FirebaseFirestore.instance
                .collection('groups')
                .doc(groupId)
                .update(
              {
                'participants': participants,
                'participantsData': participantsData,
              },
            );
          }
        }
      }
    }
  }

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
    newGroup.image = '';
    newGroup.participants = [];
    newGroup.participantsData = [];
    image = null;
    newGroup.maxParticipants = 0;
    newGroup.allowEditImage = false;
    newGroup.startDate = null;
    newGroup.endDate = null;
    groupCurrencyCode = 'BRL';
    updateIndex(0);
    notifyListeners();
  }
}
