import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  User? _user;
  User get user => _user!;
  final _auth = FirebaseAuth.instance;
  var verificationId = '';
  final phoneController = TextEditingController();

  Future<void> googleLogin() async {
    final googleProvider = GoogleAuthProvider();

    await FirebaseAuth.instance.signInWithProvider(googleProvider);
    _user = FirebaseAuth.instance.currentUser;

    notifyListeners();
  }

  Future<void> appleLogin() async {
    final appleProvider = AppleAuthProvider();

    await FirebaseAuth.instance.signInWithProvider(appleProvider);
    _user = FirebaseAuth.instance.currentUser;

    notifyListeners();
  }

  Future<void> phoneLogin() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    auth.verifyPhoneNumber(
      phoneNumber: phoneController.text,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (credential) async {
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          // ignore: avoid_print
          print('The provided phone number is not valid.');
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        String smsCode = 'xxxx';

        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: smsCode);

        await auth.signInWithCredential(credential);
      },
      codeAutoRetrievalTimeout: ((verificationId) {
        this.verificationId = verificationId;
      }),
    );
  }

  Future<bool> verifyOTP(String otp) async {
    var credentials = await _auth.signInWithCredential(
      PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otp),
    );
    return credentials.user != null ? true : false;
  }
}
