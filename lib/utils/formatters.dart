import 'package:intl/intl.dart';

class Formatters {
  static final NumberFormat _currencyFormatter = NumberFormat.currency(
    locale: 'en_IN',
    symbol: '₹',
    decimalDigits: 0,
  );

  static final DateFormat _dateFormatter = DateFormat('dd MMM yyyy');

  static String formatCurrency(double amount) {
    return _currencyFormatter.format(amount.round());
  }

  static String formatEmiMonthly(double amount) {
    return '${_currencyFormatter.format(amount.round())}/mo';
  }

  static String formatDate(DateTime date) {
    return _dateFormatter.format(date);
  }
}
