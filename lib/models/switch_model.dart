import 'package:flutter/material.dart';
class SwitchModel extends ChangeNotifier {
  ValueNotifier<bool> isSwitched = ValueNotifier(false);

  void switchEdit() {
    isSwitched.value = !isSwitched.value;
    isSwitched.notifyListeners();
    notifyListeners();
  }
}