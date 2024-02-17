import 'package:flutter/services.dart';
//import 'package:intl/intl.dart';

class MoneyFormatter extends TextInputFormatter {
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      print(true);
      return newValue.copyWith(
          text: "0.00",
          selection: new TextSelection.collapsed(offset: "0.00".length));
    }

    double value = double.parse(newValue.text);

    // final formatCurrency = new NumberFormat("#,##0.00", "en_US");

    // String newText = formatCurrency.format(value/100);
    String newText = '';
    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}
