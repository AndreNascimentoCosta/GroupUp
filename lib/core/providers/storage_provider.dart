import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groupup/core/providers/create_group_provider.dart';
import 'package:provider/provider.dart';
import 'package:groupup/core/providers/auth_provider.dart';

class StorageProvider extends ChangeNotifier {
  File? profilePicture;
  File? image;
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
        .child(
          authProvider.user!.id,
        )
        .child(
          '${authProvider.user!.id}.jpg',
        );

    final result = await ref.putFile(profilePicture);

    final url = await result.ref.getDownloadURL();
    await authProvider.updateProfilePicture(url);
    isLoading = false;
    this.profilePicture = null;
    notifyListeners();
  }

  Future<String?> addStoryMedia(BuildContext context, File image) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final createdAt = Timestamp.now().nanoseconds;
    if (authProvider.user == null) return null;
    final ref = FirebaseStorage.instance
        .ref()
        .child(authProvider.user!.id)
        .child('story_${authProvider.user!.id}$createdAt.jpg');

    final result = await ref.putFile(image);

    final url = await result.ref.getDownloadURL();
    return url;
  }

  Future<void> uploadGroupImage(BuildContext context, String groupId) async {
    final createGroupProvider =
        Provider.of<CreateGroupProvider>(context, listen: false);
    isLoading = true;
    notifyListeners();
    final image = this.image;
    if (image == null) return;
    final fileExtension = image.path.split('.').last;
    final groupCreatedAt = Timestamp.now().nanoseconds;
    final ref = FirebaseStorage.instance
        .ref()
        .child(groupId)
        .child('groupImage$groupCreatedAt.$fileExtension');

    final result = await ref.putFile(image);

    final url = await result.ref.getDownloadURL();
    await createGroupProvider.updateGroupImage(url, groupId);
    isLoading = false;
    this.image = null;
    notifyListeners();
  }
}
