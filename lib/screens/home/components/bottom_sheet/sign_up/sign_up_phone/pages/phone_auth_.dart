import 'package:flutter/material.dart';
import 'package:groupup/screens/home/components/bottom_sheet/sign_up/auth_provider.dart';
import 'package:provider/provider.dart';

class PhoneAuthenProvider extends ChangeNotifier {
  final phoneController = TextEditingController();
  final otpCode = TextEditingController();
  final controller = PageController(initialPage: 0);
  int pageIndex = 0;

  PhoneAuthenProvider() {
    phoneController.addListener(notifyListeners);
  }

  void Function()? nextPressedPhone(BuildContext context) {
    // Index 0
    final phoneControllerText = phoneController.text;

    if ((phoneControllerText.isEmpty)) {
      return null;
    } else {
      return () => {
            if (pageIndex == 0)
              {
                controller.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                )
              }
            else if (pageIndex == 1)
              {
                Provider.of<AuthProvider>(context).phoneLogin(context),
              }
            else
              {
                FocusNode().unfocus(),
                clean(),
                Navigator.pop(context),
              }
          };
    }
  }

  void updateIndex(int index) {
    pageIndex = index;
    notifyListeners();
  }

  void clean() {
    phoneController.clear();
    otpCode.clear();
    updateIndex(0);
    notifyListeners();
  }
}
