import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:groupup/screens/home/components/bottom_sheet/sign_up/sign_up_phone/pages/phone_auth_.dart';
import 'package:provider/provider.dart';

class AuthProvider extends ChangeNotifier {
  User? _user;
  User get user => _user!;
  final _auth = FirebaseAuth.instance;
  String verificationId = '';
  final googleSignIn = GoogleSignIn();
  bool loading = false;

  AuthProvider() {
    _user = FirebaseAuth.instance.currentUser;
  }

  Future<void> googleLogin() async {
    try {
      loading = true;
      notifyListeners();
      final googleProvider = GoogleAuthProvider();

      await FirebaseAuth.instance.signInWithProvider(googleProvider);
      _user = FirebaseAuth.instance.currentUser;
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
      final appleProvider = AppleAuthProvider();

      await FirebaseAuth.instance.signInWithProvider(appleProvider);
      _user = FirebaseAuth.instance.currentUser;
      loading = false;
    } on FirebaseAuthException catch (e) {
      loading = false;
    }
    notifyListeners();
  }

  Future<void> phoneLogin(BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await auth.verifyPhoneNumber(
      phoneNumber:
          Provider.of<PhoneAuthenProvider>(context).phoneController.text,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (credential) async {
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (e) {
        SnackBar(content: Text(e.message!));
      },
      codeSent: (String verificationId, int? resendToken) async {
        Provider.of<PhoneAuthenProvider>(context).controller.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            );
        this.verificationId = verificationId;

        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId,
            smsCode: Provider.of<PhoneAuthenProvider>(context).otpCode.text);
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

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
