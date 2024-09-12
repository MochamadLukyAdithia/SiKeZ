import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  DateTime copy() =>
      DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch, isUtc: isUtc);

  String toyyyyMMdd() => DateFormat('yyyy-MM-dd').format(this);

  String toyyyyMMddSlash() => DateFormat('yyyy/MM/dd').format(this);

  String toyyyyMMddhhmmss() => DateFormat('yyyy-MM-dd hh:mm:ss').format(this);

  String toyyyyMMddHHmmss() => DateFormat('yyyy-MM-dd HH:mm:ss').format(this);

  String toyyyyMMddhhmmssa() =>
      DateFormat('yyyy-MM-dd hh:mm:ss a').format(this);

  String toddMMyyyy() => DateFormat('dd/MM/yyyy').format(this);

  String toMMddyyyy() => DateFormat('MM/dd/yyyy').format(this);

  String toddMMMyyyy() => DateFormat('dd MMM yyyy').format(this);

  String toMMMddyyyyhmma() => DateFormat('MMM dd, yyyy - h.mm a').format(this);

  String toMMMddyyyyhhmm() => DateFormat('MMM dd, yyyy - hh.mm').format(this);

  String toddMMMMyyyy() => DateFormat('dd MMMM yyyy').format(this);

  String toddMMMM() => DateFormat('dd MMMM').format(this);

  String toddMMM() => DateFormat('dd MMM').format(this);

  String toddMMMMyyyyWithStrip() => DateFormat('dd-MMMM-yyyy').format(this);

  String toMMMddyyyy() => DateFormat('MMM dd, yyyy').format(this);

  String toMMMyy() => DateFormat('MMM yy').format(this);

  String toMMMdd() => DateFormat('MMM dd').format(this);

  String toddMMMhhmm() => DateFormat('dd MMM, hh:mm').format(this);

  String toddMMMMyyyyhhmm() => DateFormat('dd MMMM yyyy hh:mm').format(this);

  String toddMMMMyyyyHHmm() => DateFormat('dd MMMM yyyy HH:mm').format(this);

  String tohhmm() => DateFormat('hh:mm').format(this);

  String toHHmm() => DateFormat('HH:mm').format(this);

  String toHHmmss() => DateFormat('HH:mm:ss').format(this);

  String toDayName() => DateFormat('EEEE').format(this);

  String toddmmyyyy() => DateFormat('dd/mm/yyyy').format(this);

  String timeAgoSinceDate({bool numericDates = true}) {
    final date2 = DateTime.now();
    final difference = date2.difference(this);

    if (difference.inDays > 2) {
      return toddMMMhhmm();
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 hari' : 'Kemarin, ${tohhmm()}';
    } else if (difference.inHours >= 4) {
      return tohhmm();
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} jam';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inSeconds >= 2) {
      return '${difference.inSeconds} detik';
    } else {
      return 'Baru saja';
    }
  }

  static DateTime minDateTime = DateTime.utc(1900, 01, 02);

  DateTime? get validDate {
    if (isAfter(minDateTime)) {
      return this;
    }
    return null;
  }

  bool isToday() {
    final now = DateTime.now();
    return day == now.day && month == now.month && year == now.year;
  }

  bool isThisMonth() {
    final now = DateTime.now();

    return month == now.month && year == now.year;
  }

  bool validateRangeDate(DateTime tanggalEnd) {
    // ignore: unnecessary_null_comparison
    if (this == null || tanggalEnd == null) {
      return true;
    }
    return isBefore(tanggalEnd) || isAtSameMomentAs(tanggalEnd);
  }

  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  int get weekOfMonth {
    var date = this;
    final firstDayOfTheMonth = DateTime(date.year, date.month, 1);
    int sum = firstDayOfTheMonth.weekday - 1 + date.day;
    if (sum % 7 == 0) {
      return sum ~/ 7;
    } else {
      return sum ~/ 7 + 1;
    }
  }

  DateTime get simplified {
    return DateTime(year, month, day);
  }
}
