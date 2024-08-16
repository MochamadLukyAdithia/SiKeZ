import 'package:intl/intl.dart';

String formatCurrency(int amount) {
  final formatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp',
    decimalDigits: 2,
  );
  return formatter.format(amount);
}
