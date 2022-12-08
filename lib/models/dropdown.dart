import 'package:flutter/material.dart';

class DropDownModel extends ChangeNotifier {
  ValueNotifier<bool> isOpened = ValueNotifier(false);

  void switchEdit() {
    isOpened.value = !isOpened.value;
    isOpened.notifyListeners();
    notifyListeners();
  }
}