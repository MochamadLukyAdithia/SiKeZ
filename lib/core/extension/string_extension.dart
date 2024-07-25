import 'package:intl/intl.dart';

final formatNumber = NumberFormat("#,##0", "id_ID");

// FOR IMPORTING IMAGE FROM LOCAL ASSETS
extension ImageStringExtension on String {
  String get jpg => 'assets/images/$this.jpg';
  String get png => 'assets/images/$this.png';
  String get svg => 'assets/icons/$this.svg';
}

extension MoneyStringFormat on String {
  String get currentcy => 'Rp${formatNumber.format(int.parse(this))}';
  String get idrCurrency =>
      NumberFormat.currency(locale: 'id_ID', symbol: "Rp ")
          .format(double.parse(this));
}

extension ToFixedString on String {
  String get toStringAsFixed0 => double.parse(this).toInt().toString();
}
