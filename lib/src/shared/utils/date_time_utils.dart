import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

const String dateTimeFormatPattern = 'dd/MM/yyyy';

extension DateTimeExtension on DateTime {
  String format([
    String pattern = dateTimeFormatPattern,
    String? locale,
  ]) {
    if (locale != null && locale.isNotEmpty) {
      initializeDateFormatting(locale);
    }
    return DateFormat(pattern, locale).format(this);
  }

  //THU 26 May, 09:00
  String get toReadable {
    return DateFormat('EEE, dd MMM YYYY · HH:mm').format(this);
  }

  //THU 26 May
  String get toReadableDate {
    return DateFormat('EEE, dd MMM YYYY').format(this);
  }

  //30-09-2024 09:00 PM
  String get toReadableWithTime {
    return DateFormat('dd-MM-yyyy hh:mm a').format(this);
  }

  String get toCategory {
    final today = DateTime.now();
    final yesterday = today.subtract(const Duration(days: 1));
    if (year == today.year && month == today.month && day == today.day) {
      return 'Today';
    } else if (year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day) {
      return 'Yesterday';
    } else {
      //30 Sept 2024
      return format('dd MMM yyyy');
    }
  }
}
