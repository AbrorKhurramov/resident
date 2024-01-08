import 'package:flutter/services.dart';

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    print(oldValue.text.toString());
    print(newValue.text.toString());
    String newChangedValue = newValue.text;

    if (oldValue.text.length < newValue.text.length) {
      if (newValue.text.length == 4) {
        newChangedValue = newValue.text.substring(0, 4) + ' ';
      }
      if (newValue.text.length == 9) {
        newChangedValue = newValue.text.substring(0, 9) + ' ';
      }
      if (newValue.text.length == 14) {
        newChangedValue = newValue.text.substring(0, 14) + ' ';
      }
    }

    return newValue.copyWith(
        text: newChangedValue,
        selection: TextSelection.collapsed(offset: newChangedValue.length));
  }
}
