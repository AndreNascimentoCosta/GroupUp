import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groupup/core/providers/stripe_payment_provider.dart';
import 'package:groupup/models/group_model.dart';
import 'package:groupup/models/participant.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:provider/provider.dart';

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
  bool isPaying = false;

  JoinGroupProvider() {
    controllerGroupCode.addListener(notifyListeners);
  }

  void Function()? nextPressedJoin(
    BuildContext context,
    String groupId,
    String userId,
    String reward,
    String groupCurrencyCode,
  ) {
    // Index 0
    final joinGroupText = controllerGroupCode.text;

    if ((joinGroupText.isEmpty)) {
      return null;
    } else {
      return () async {
        final scaffoldMessengerState = ScaffoldMessenger.of(context);
        final navigatorState = Navigator.of(context);
        final initPayment =
            Provider.of<StripePaymentProvider>(context, listen: false)
                .initPayment(
          context,
          userId,
          reward,
          groupCurrencyCode,
        );
        FocusScope.of(context).unfocus();
        isPaying = true;
        notifyListeners();
        await initPayment;
        isPaying = false;
        notifyListeners();
        final error = await joinGroup(context);
        switch (error) {
          case JoinGroupErrorType.groupCodeEmpty:
            scaffoldMessengerState.showSnackBar(
              const SnackBar(
                content: Text('Please enter a group code'),
              ),
            );
            break;
          case JoinGroupErrorType.groupCodeInvalid:
            scaffoldMessengerState.showSnackBar(
              const SnackBar(
                content: Text('Invalid group code'),
              ),
            );
            break;
          case JoinGroupErrorType.groupCodeExpired:
            scaffoldMessengerState.showSnackBar(
              const SnackBar(
                content: Text('This group has already ended'),
              ),
            );
            break;
          case JoinGroupErrorType.groupCodeFull:
            scaffoldMessengerState.showSnackBar(
              const SnackBar(
                content: Text('This group code is full'),
              ),
            );
            break;
          case JoinGroupErrorType.userAlreadyInGroup:
            scaffoldMessengerState.showSnackBar(
              const SnackBar(
                content: Text('You are already in this group'),
              ),
            );
            break;
          default:
        }
        clean();
        navigatorState.pop();
        navigatorState.pop();
      };
    }
  }

  Future<JoinGroupErrorType?> joinGroup(BuildContext context) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final user = Provider.of<AuthProvider>(context, listen: false).user;
    final groups = await FirebaseFirestore.instance
        .collection('groups')
        .where('groupCode', isEqualTo: controllerGroupCode.text.toUpperCase())
        .get();
    if (groups.docs.isEmpty) {
      return JoinGroupErrorType.groupCodeInvalid;
    }
    final groupDocument = groups.docs.first;
    final groupData = groupDocument.data();
    final groupModel = GroupModel.fromMap(groupDocument.id, groupData);
    if (groupModel.participants.contains(userId)) {
      return JoinGroupErrorType.userAlreadyInGroup;
    }
    if (groupModel.participants.length >= groupModel.maxParticipants) {
      return JoinGroupErrorType.groupCodeFull;
    }
    if (groupModel.endDate!.isBefore(DateTime.now())) {
      return JoinGroupErrorType.groupCodeExpired;
    }
    if (user == null) {
      return JoinGroupErrorType.groupCodeInvalid;
    }
    await FirebaseFirestore.instance
        .collection('groups')
        .doc(groups.docs.first.id)
        .update(
      {
        'participants': FieldValue.arrayUnion([userId]),
        'participantsData': FieldValue.arrayUnion(
          [
            Participant(
              uid: userId,
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
