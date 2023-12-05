import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/extensions/gp_navigator_extension.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';
import 'package:groupup/core/widgets/texts/gp_text_header.dart';
import 'package:groupup/models/group_model.dart';
import 'package:groupup/models/user_data.dart';
import 'package:groupup/core/providers/phone_auth_provider.dart';
import 'package:groupup/core/widgets/buttons/gp_button.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'mix_panel_provider.dart';

class AuthProvider extends ChangeNotifier {
  UserDataModel? _user;
  UserDataModel? get user => _user;
  final _auth = FirebaseAuth.instance;
  String verificationId = '';
  int? resendToken;
  final googleSignIn = GoogleSignIn();
  bool loading = false;

  AuthProvider() {
    getUser();
  }

  Future<void> getUser() async {
    final user = _auth.currentUser;
    if (user != null) {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      final userMap = userDoc.data();
      if (userMap == null) return;
      userMap['id'] = user.uid;
      _user = UserDataModel.fromMap(userMap);
      notifyListeners();
    }
  }

  Future<void> updateProfilePicture(String imageUrl) async {
    final user = _user;
    if (user == null) return;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.id)
        .update({'profilePicture': imageUrl});
    final groups = await FirebaseFirestore.instance
        .collection('groups')
        .where('participants', arrayContains: user.id)
        .get();
    for (final group in groups.docs) {
      final participantsData =
          GroupModel.fromMap(group.id, group.data()).participantsData;
      final userIndex =
          participantsData.indexWhere((element) => element.uid == user.id);
      participantsData[userIndex].profilePicture = imageUrl;
      await FirebaseFirestore.instance
          .collection('groups')
          .doc(group.id)
          .update(
        {'participantsData': participantsData.map((e) => e.toMap()).toList()},
      );
    }
    await getUser();
  }

  Future<void> updateProfileName(String nameController) async {
    final user = _user;
    if (user == null) return;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.id)
        .update({'name': nameController});
    final groups = await FirebaseFirestore.instance
        .collection('groups')
        .where('participants', arrayContains: user.id)
        .get();
    for (final group in groups.docs) {
      final participantsData =
          GroupModel.fromMap(group.id, group.data()).participantsData;
      final userIndex =
          participantsData.indexWhere((element) => element.uid == user.id);
      participantsData[userIndex].name = nameController;
      await FirebaseFirestore.instance
          .collection('groups')
          .doc(group.id)
          .update(
        {'participantsData': participantsData.map((e) => e.toMap()).toList()},
      );
    }
    await getUser();
  }

  Future<void> updateStripeAccountId(String accountId) async {
    final user = _user;
    if (user == null) return;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.id)
        .update({'stripeAccountId': accountId});
    await getUser();
  }

  Future<void> updateSocialUserData() async {
    final user = _auth.currentUser;
    if (user == null) return;

    final previousDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    if (previousDoc.exists) return;

    final userData = UserDataModel(
      id: user.uid,
      name: user.displayName ?? '',
      email: user.email ?? '',
      profilePicture: user.photoURL ?? '',
      phoneNumber: '',
      balance: 0.0,
      stripeAccountId: '',
      paymentIntentIds: [],
    );
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .set(userData.toMap());
  }

  Future<void> updatePhoneUserData({
    required String name,
    required String phoneNumber,
  }) async {
    final user = _auth.currentUser;
    if (user == null) return;

    final previousDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    if (previousDoc.exists) return;

    final userData = UserDataModel(
      id: user.uid,
      name: name,
      email: '',
      profilePicture: user.photoURL ?? '',
      phoneNumber: phoneNumber,
      balance: 0.0,
      stripeAccountId: '',
      paymentIntentIds: [],
    );
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .set(userData.toMap());
  }

  Future<void> updateNameUserData({
    required String name,
  }) async {
    final user = this.user;

    if (user == null) return;
    user.name = name;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.id)
        .set(user.toMap());
  }

  void _error(BuildContext context, String e) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: GPTextHeader(
            text: AppLocalizations.of(context).error,
            textAlign: TextAlign.center,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: GPTextBody(
              text: e,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          contentPadding: const EdgeInsets.only(top: 20, bottom: 20),
          actions: [
            GPButton(
              text: 'Ok',
              borderColor: GPColors.primaryColor,
              onPressed: () {
                Provider.of<MixPanelProvider>(context, listen: false)
                    .logEvent(eventName: 'Error', properties: {'Error': e});
                context.pop();
              },
              height: 40,
              width: 140,
            ),
          ],
        );
      },
    );
  }

  Future<void> phoneLogin(BuildContext context) async {
    final mixPanelProvider =
        Provider.of<MixPanelProvider>(context, listen: false);
    final phoneProvider =
        Provider.of<PhoneAuthenProvider>(context, listen: false);
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneProvider.phoneController,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (e) {
        if (e.code == 'invalid-phone-number') {
          mixPanelProvider.logEvent(
            eventName: 'Phone Login Error',
            properties: {'error': e.message},
          );
          _error(context, AppLocalizations.of(context).invalidPhoneNumber);
        } else if (e.code == 'too-many-requests') {
          mixPanelProvider.logEvent(
            eventName: 'Phone Login Error',
            properties: {'error': e.message},
          );
          _error(context, AppLocalizations.of(context).tooManyRequests);
        } else {
          mixPanelProvider.logEvent(
            eventName: 'Phone Login Error',
            properties: {'error': e.message},
          );
          _error(context, AppLocalizations.of(context).error);
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        if (phoneProvider.pageIndex == 0) {
          phoneProvider.controller.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        }
        this.verificationId = verificationId;
        this.resendToken = resendToken;
      },
      forceResendingToken: resendToken,
      codeAutoRetrievalTimeout: ((verificationId) {
        this.verificationId = verificationId;
      }),
    );
  }

  Future<void> verifyOTP(BuildContext context) async {
    final mixPanelProvider =
        Provider.of<MixPanelProvider>(context, listen: false);
    final phoneProvider =
        Provider.of<PhoneAuthenProvider>(context, listen: false);
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: phoneProvider.otpCode);
    final navigatorState = context;
    try {
      await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-verification-code') {
        _error(context, AppLocalizations.of(context).invalidVerificationCode);
        return;
      } else {
        return;
      }
    }
    navigatorState.pop();
    if (_user == null) {
      return;
    } else {
      await updatePhoneUserData(
        name: phoneProvider.nameController.text,
        phoneNumber: phoneProvider.phoneController,
      );
      await getUser();
      notifyListeners();
      mixPanelProvider.setUserId(_user!.id);
    }
  }

  Future<void> signOut(BuildContext context) async {
    final mixPanelProvider =
        Provider.of<MixPanelProvider>(context, listen: false);
    await FirebaseAuth.instance.signOut();
    await mixPanelProvider.logEvent(
      eventName: 'Sign Out',
    );
    mixPanelProvider.removeUser();
  }
}
