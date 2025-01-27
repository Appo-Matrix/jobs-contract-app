import 'package:intl/intl.dart';

class JFormatter {

  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('dd-MMM-yyyy').format(date);
  }

  static String formatCurrency(double amount){
    return NumberFormat.currency(locale: 'en_US',symbol: '\$').format(amount);
  }

  static String formatToken(double quantity){
    return NumberFormat.currency(locale: 'en_US',symbol: '').format(quantity);
  }

  static String formatCardNumber(String cardNumber) {
    String sanitized = cardNumber.replaceAll(RegExp(r'\D'), '');
    return sanitized.replaceAllMapped(
      RegExp(r"(\d{4})(?=\d)"),
          (match) => "${match.group(1)} ",
    );
  }


}