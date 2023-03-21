import 'dart:async';

import 'package:flutter/material.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import 'mix_panel_provider.dart';

class PhoneAuthenProvider extends ChangeNotifier {
  String get otpCode {
    return otpCode1.text +
        otpCode2.text +
        otpCode3.text +
        otpCode4.text +
        otpCode5.text +
        otpCode6.text;
  }

  final otpCode1 = TextEditingController();
  final otpCode2 = TextEditingController();
  final otpCode3 = TextEditingController();
  final otpCode4 = TextEditingController();
  final otpCode5 = TextEditingController();
  final otpCode6 = TextEditingController();
  final nameController = TextEditingController();
  String phoneController = '';
  int start = 30;
  final controller = PageController(initialPage: 0);
  int pageIndex = 0;
  Timer? timer;

  void setPhone(String phone) {
    phoneController = phone;
    notifyListeners();
  }

  void onPaste(String value) {
    if (value.length == 6) {
      otpCode1.text = value[0];
      otpCode2.text = value[1];
      otpCode3.text = value[2];
      otpCode4.text = value[3];
      otpCode5.text = value[4];
      otpCode6.text = value[5];
    }
    notifyListeners();
  }

  PhoneAuthenProvider() {
    otpCode1.addListener(notifyListeners);
    otpCode2.addListener(notifyListeners);
    otpCode3.addListener(notifyListeners);
    otpCode4.addListener(notifyListeners);
    otpCode5.addListener(notifyListeners);
    otpCode6.addListener(notifyListeners);
    nameController.addListener(notifyListeners);
  }

  void startTimer() {
    const onesec = Duration(seconds: 1);
    start = 30;
    timer?.cancel();
    timer = Timer.periodic(
      onesec,
      (timer) {
        if (start == 0) {
          timer.cancel();
          notifyListeners();
        } else {
          start--;
          notifyListeners();
        }
      },
    );
  }

  void Function()? nextPressedPhone(BuildContext context) {
    // Index 0
    if (pageIndex == 0 && phoneController.isEmpty) {
      return null;
    } else {
      return () => {
            Provider.of<MixPanelProvider>(context, listen: false)
                .logEvent(eventName: 'Next Button Phone'),
            Provider.of<AuthProvider>(context, listen: false)
                .phoneLogin(context),
            FocusScope.of(context).requestFocus(),
            startTimer(),
          };
    }
  }

  void Function()? nextPressedName(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    // Index 0
    if (pageIndex == 0 && nameController.text.isEmpty) {
      return null;
    } else {
      return () => {
            Provider.of<MixPanelProvider>(context, listen: false)
                .logEvent(eventName: 'Update Name'),
            authProvider.updateNameUserData(
              name: nameController.text,
            ),
            authProvider.getUser(),
            Navigator.pop(context),
            notifyListeners(),
          };
    }
  }

  void updateIndex(int index) {
    pageIndex = index;
    notifyListeners();
  }

  void cleanOtp() {
    otpCode1.clear();
    otpCode2.clear();
    otpCode3.clear();
    otpCode4.clear();
    otpCode5.clear();
    otpCode6.clear();
    notifyListeners();
  }

  void cleanName() {
    nameController.clear();
    notifyListeners();
  }

  void clean() {
    phoneController = '';
    otpCode1.clear();
    otpCode2.clear();
    otpCode3.clear();
    otpCode4.clear();
    otpCode5.clear();
    otpCode6.clear();
    nameController.clear();
    updateIndex(0);
    notifyListeners();
  }
}
