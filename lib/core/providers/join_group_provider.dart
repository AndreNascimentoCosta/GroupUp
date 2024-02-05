// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groupup/core/extensions/gp_navigator_extension.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/models/group_model.dart';
import 'package:groupup/models/participant_model.dart';
import 'package:groupup/modules/join_group/components/join_group_events.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum JoinGroupErrorType {
  groupCodeEmpty,
  groupCodeInvalid,
  groupCodeExpired,
  groupCodeFull,
  userAlreadyInGroup,
}

class JoinGroupProvider extends ChangeNotifier {
  final controllerGroupCode = TextEditingController();
  final controller = PageController();
  int pageIndex = 0;
  bool isOpeningSavedCards = false;

  JoinGroupProvider() {
    controllerGroupCode.addListener(notifyListeners);
  }

  void Function()? nextButtonJoin(
    BuildContext context,
    String userId,
  ) {
    final joinGroupText = controllerGroupCode.text;
    if ((joinGroupText.isEmpty)) {
      return null;
    } else if (pageIndex == 0) {
      return () async {
        Provider.of<MixPanelProvider>(context, listen: false).logEvent(
          eventName: JoinGroupEvents.pressNextButtonJoinGroup.value,
        );
        FocusScope.of(context).unfocus();
        final scaffoldMessengerState = ScaffoldMessenger.of(context);
        final appLocalizations = AppLocalizations.of(context)!;
        final error = await validateJoinGroup(context);
        if (error != null) {
          switch (error) {
            case JoinGroupErrorType.groupCodeEmpty:
              scaffoldMessengerState.showSnackBar(
                SnackBar(
                  content: Text(appLocalizations.pleaseEnterGroupCode),
                  duration: const Duration(seconds: 2),
                ),
              );
              break;
            case JoinGroupErrorType.groupCodeInvalid:
              scaffoldMessengerState.showSnackBar(
                SnackBar(
                  content: Text(appLocalizations.invalidGroupCode),
                  duration: const Duration(seconds: 2),
                ),
              );
              break;
            case JoinGroupErrorType.groupCodeExpired:
              scaffoldMessengerState.showSnackBar(
                SnackBar(
                  content: Text(appLocalizations.groupAlreadyEnded),
                  duration: const Duration(seconds: 2),
                ),
              );
              break;
            case JoinGroupErrorType.groupCodeFull:
              scaffoldMessengerState.showSnackBar(
                SnackBar(
                  content: Text(appLocalizations.groupAlreadyFull),
                  duration: const Duration(seconds: 2),
                ),
              );
              break;
            case JoinGroupErrorType.userAlreadyInGroup:
              scaffoldMessengerState.showSnackBar(
                SnackBar(
                  content: Text(appLocalizations.userAlreadyInTheGroup),
                  duration: const Duration(seconds: 2),
                ),
              );
              break;
            default:
          }
          return;
        }
        controller.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      };
    } else {
      return () async {
        Provider.of<MixPanelProvider>(context, listen: false).logEvent(
          eventName: JoinGroupEvents.pressJoinGroupButton.value,
        );
        final navigatorState = context;
        final user = Provider.of<AuthProvider>(context, listen: false).user;
        FocusScope.of(context).unfocus();
        await joinGroup(user);
        navigatorState.pop();
        navigatorState.pop();
        clean();
      };
    }
  }

  Future<JoinGroupErrorType?> validateJoinGroup(BuildContext context) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final navigatorState = context;
    final groups = await FirebaseFirestore.instance
        .collection('groups')
        .where('groupCode', isEqualTo: controllerGroupCode.text.toUpperCase())
        .get();
    if (groups.docs.isEmpty) {
      navigatorState.pop();
      navigatorState.pop();
      return JoinGroupErrorType.groupCodeInvalid;
    }
    final groupDocument = groups.docs.first;
    final groupData = groupDocument.data();
    final groupModel = GroupModel.fromMap(groupDocument.id, groupData);
    if (groupModel.participants.contains(userId)) {
      navigatorState.pop();
      navigatorState.pop();
      return JoinGroupErrorType.userAlreadyInGroup;
    }
    if (groupModel.participants.length >= groupModel.maxParticipants) {
      navigatorState.pop();
      navigatorState.pop();
      return JoinGroupErrorType.groupCodeFull;
    }
    if (groupModel.endDate!.year != (DateTime.now()).year ||
        groupModel.endDate!.month != (DateTime.now()).month ||
        groupModel.endDate!.day != (DateTime.now()).day) {
      if (groupModel.endDate!.isBefore((DateTime.now()))) {
        navigatorState.pop();
        navigatorState.pop();
        return JoinGroupErrorType.groupCodeExpired;
      }
    }
    return null;
  }

  Future<JoinGroupErrorType?> joinGroup(user) async {
    final group = await FirebaseFirestore.instance
        .collection('groups')
        .where('groupCode', isEqualTo: controllerGroupCode.text.toUpperCase())
        .get();
    if (group.docs.isEmpty) {
      return JoinGroupErrorType.groupCodeInvalid;
    }
    if (user == null) {
      return JoinGroupErrorType.groupCodeInvalid;
    }
    await FirebaseFirestore.instance
        .collection('groups')
        .doc(group.docs.first.id)
        .update(
      {
        'participants': FieldValue.arrayUnion([user.id]),
        'participantsData': FieldValue.arrayUnion(
          [
            Participant(
              uid: user.id,
              name: user.name,
              profilePicture: user.profilePicture,
              inputData: [],
              isAdmin: false,
            ).toMap()
          ],
        )
      },
    );
    return null;
  }

  void updateIndex(int index) {
    pageIndex = index;
    notifyListeners();
  }

  void clean() {
    controllerGroupCode.clear();
    updateIndex(0);
    notifyListeners();
  }
}
