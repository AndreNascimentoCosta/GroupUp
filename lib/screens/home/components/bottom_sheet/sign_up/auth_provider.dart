import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/user_data.dart';
import 'package:groupup/screens/home/components/bottom_sheet/sign_up/sign_up_phone/pages/phone_auth_.dart';
import 'package:groupup/screens/home/components/next_button.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthProvider extends ChangeNotifier {
  UserDataModel? _user;
  UserDataModel? get user => _user;
  final _auth = FirebaseAuth.instance;
  String verificationId = '';
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
    final user = _auth.currentUser;
    if (user == null) return;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .update({'profilePicture': imageUrl});
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
    );
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .set(userData.toMap());
  }

  Future<void> googleLogin() async {
    try {
      loading = true;
      notifyListeners();
      final googleProvider = GoogleAuthProvider();

      await FirebaseAuth.instance.signInWithProvider(googleProvider);
      await updateSocialUserData();
      await getUser();
      loading = false;
    } on FirebaseAuthException catch (e) {
      loading = false;
    }
    notifyListeners();
  }

  Future<void> appleLogin() async {
    try {
      loading = true;
      notifyListeners();
      final credentials = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName
        ],
      );
      final firebaseCredentials = OAuthProvider('apple.com').credential(
        idToken: credentials.identityToken,
        accessToken: credentials.authorizationCode,
      );

      await FirebaseAuth.instance.signInWithCredential(firebaseCredentials);
      await _auth.currentUser?.updateDisplayName(
          "${credentials.givenName} ${credentials.familyName}");
      await updateSocialUserData();
      await getUser();
      loading = false;
    } on FirebaseAuthException catch (e) {
      loading = false;
    }
    notifyListeners();
  }

  void _error(BuildContext context, String e) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const StaticText(
            text: 'Error',
            textAlign: TextAlign.center,
            fontFamily: 'Montserrat-SemiBold',
            fontSize: TextSize.lBody,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: StaticText(
            text: e,
            maxLines: 2,
            textAlign: TextAlign.center,
            fontSize: TextSize.mBody,
          ),
          actionsAlignment: MainAxisAlignment.center,
          contentPadding: const EdgeInsets.only(top: 20, bottom: 20),
          actions: [
            NextButton(
              text: 'Ok',
              borderColor: kPrimaryColor,
              onPressed: () => Navigator.of(context).pop(),
              height: 40,
              width: 140,
            ),
          ],
        );
      },
    );
  }

  Future<void> phoneLogin(BuildContext context) async {
    final phoneAuth = Provider.of<PhoneAuthenProvider>(context, listen: false);

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneAuth.phoneController.text,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (e) {
        if (e.code == 'invalid-phone-number') {
          _error(context, 'Invalid phone number');
        } else {
          _error(context, 'Something went wrong');
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        phoneAuth.controller.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        );
        this.verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: ((verificationId) {
        this.verificationId = verificationId;
      }),
    );
  }

  Future<void> verifyOTP(String otp) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otp);
    await _auth.signInWithCredential(credential);
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
