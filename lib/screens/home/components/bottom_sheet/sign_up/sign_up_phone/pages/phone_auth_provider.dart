import 'dart:io';

import 'package:flutter/material.dart';
import 'package:groupup/screens/home/components/bottom_sheet/sign_up/auth_provider.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';

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
  final phoneController = TextEditingController();
  final countryCode = PhoneNumber(isoCode: Platform.localeName.split('_')[1]);
  // String get wholePhoneNumber {
  //   return countryCode + phoneController.text;
  // }

  final controller = PageController(initialPage: 0);
  int pageIndex = 0;

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
    phoneController.addListener(notifyListeners);
  }

  void Function()? nextPressedPhone(BuildContext context) {
    // Index 0
    if (pageIndex == 0 && nameController.text.length < 3) {
      return null;
    } else if (pageIndex == 1 && phoneController.text.isEmpty) {
      return null;
    } else {
      return () => {
            if (pageIndex == 0)
              {
                controller.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                ),
                FocusScope.of(context).unfocus(),
              }
            else if (pageIndex == 1)
              {
                FocusScope.of(context).unfocus(),
                Provider.of<AuthProvider>(context, listen: false)
                    .phoneLogin(context),
                print(phoneController.text),
              }
            else
              {
                Provider.of<AuthProvider>(context, listen: false)
                    .verifyOTP(context),
                FocusNode().unfocus(),
                Navigator.pop(context),
              }
          };
    }
  }

  // final _instance = FirebaseFirestore.instance;

  // Future<bool> userExists(String username) async =>
  //     (await _instance
  //             .collection("users")
  //             .where("username", isEqualTo: username)
  //             .get())
  //         .docs.isNotEmpty;

  void updateIndex(int index) {
    pageIndex = index;
    notifyListeners();
  }

  void clean() {
    phoneController.clear();
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