import 'package:intl/intl.dart';

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) {
      return "";
    }
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

extension LowerCaseList on List<String> {
  void toLowerCase() {
    for (int i = 0; i < length; i++) {
      this[i] = this[i].toLowerCase();
    }
  }
}

extension RupeesFormatter on String {


  String inRupeesFormat() {
    if(this.isEmpty){
      return "0";
    }

    double amount=0;
    try {
    amount = double.parse(this);
    }catch(e){
    //  print("RupeesFormatter ERROR "+e.toString());
      return "0";
    }

    return NumberFormat.currency(
      name: "INR",
      locale: 'en_IN',
      decimalDigits: 2, // change it to get decimal places
      symbol: '₹ ',
    ).format(amount);
  }
}

extension IndianAmountFormat on String {
  String formatize() {
    if (isEmpty) {
      return "";
    }
    var format =  NumberFormat.currency(
      symbol: '₹ ',
      locale: "HI",
      decimalDigits: 3,
    ).format(this);

    return format;
  }
}


extension NullableStringExtension on String? {
  String handleNullValue() {
    return this == null || this == ""
        ? "Not Mentioned"
        : (this ?? "Not Mentioned");
  }
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
