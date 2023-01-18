import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groupup/models/participant.dart';
import 'package:groupup/screens/home/components/bottom_sheet/sign_up/auth_provider.dart';
import 'package:provider/provider.dart';

class JoinGroupProvider extends ChangeNotifier {
  final controllerGroupCode = TextEditingController();

  final controller = PageController();
  int pageIndex = 0;

  JoinGroupProvider() {
    controllerGroupCode.addListener(notifyListeners);
  }

  void Function()? nextPressedJoin(BuildContext context) {
    // Index 0
    final joinGroupText = controllerGroupCode.text;

    if ((joinGroupText.isEmpty)) {
      return null;
    } else {
      return () => {
            FocusNode().unfocus(),
            joinGroup(context),
            clean(),
            Navigator.pop(context),
            Navigator.pop(context),
          };
    }
  }

  Future<void> joinGroup(BuildContext context) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final user = Provider.of<AuthProvider>(context, listen: false).user;
    final groups = await FirebaseFirestore.instance
        .collection('groups')
        .where('groupCode', isEqualTo: controllerGroupCode.text.toUpperCase())
        .get();
    if (groups.docs.isEmpty) {
      return;
    }
    if (user == null) {
      return;
    }
    FirebaseFirestore.instance
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
