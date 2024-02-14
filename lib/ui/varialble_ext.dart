import 'package:intl/intl.dart';

extension MyExtension on String {

  String resetShiftValue(){
    try{
      return replaceAll("!", "1").replaceAll("@", "2").replaceAll("#", "3").replaceAll("\$", "4").replaceAll("%", "5")
          .replaceAll("^", "6").replaceAll("&", "7").replaceAll("*", "8").replaceAll("(", "9").replaceAll(")", "0")
          .replaceAll("_", "-").replaceAll("+", "=").replaceAll("»", "+");
    }catch(e){
      return toString();
    }
  }


  String formatPrice(){
    try{
      var formatCurrency =  NumberFormat.currency(locale: "en_US", decimalDigits: 2,name: "");
      return formatCurrency.format(this);
    }catch(e){
      return toString();
    }
  }

  String camelCase() {
    if(trim().isEmpty) return "";

    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

}



extension DoubleExtension on double {

  String formatPrice(){
    try{
      var formatCurrency =  NumberFormat.currency(locale: "en_US", decimalDigits: 2,name: "");
      return formatCurrency.format(this);
    }catch(e){
      return toString();
    }
  }

}


extension IntExtension on num {

  String formatPrice(){
    try{
      var formatCurrency =  NumberFormat.currency(locale: "en_US", decimalDigits: 2,name: "");
      return "CAD ${formatCurrency.format(this)}";
    }catch(e){
      return toString();
    }
  }

}



bool isType<T, Y>() => T == Y;