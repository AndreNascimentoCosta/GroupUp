import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  ValueNotifier<bool> isEditing = ValueNotifier(false);

  void switchEdit() {
    isEditing.value = !isEditing.value;
    isEditing.notifyListeners();
    notifyListeners();
  }
}