import 'package:flutter/services.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    try {
      final double value = double.parse(
        newValue.text.replaceAll(RegExp(r'[^\d]'), ''),
      );

      final newText = (value / 100).toString();

      return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    } on FormatException {
      return oldValue;
    }
  }
}
