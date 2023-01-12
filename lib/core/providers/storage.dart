import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:groupup/screens/home/components/bottom_sheet/sign_up/auth_provider.dart';

class StorageProvider extends ChangeNotifier {
  File? profilePicture;
  bool isLoading = false;

  Future<void> uploadProfilePicture(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final profilePicture = this.profilePicture;
    if (profilePicture == null) return;
    if (authProvider.user == null) return;
    final ref = FirebaseStorage.instance
        .ref()
        .child(authProvider.user!.id)
        .child('${authProvider.user!.id}.jpg');

    final result = await ref.putFile(profilePicture);

    final url = await result.ref.getDownloadURL();
    await authProvider.updateProfilePicture(url);
    isLoading = false;
    this.profilePicture = null;
    notifyListeners();
  }
}
