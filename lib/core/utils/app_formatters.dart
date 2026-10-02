import 'package:intl/intl.dart';

/// Centralized formatters for numbers, currency, dates, and strings.
/// Portable and dynamic across any real-world enterprise app.
class AppFormatters {
  AppFormatters._();

  /// Formats currency with customizable symbol and decimal places
  /// Example: `AppFormatters.currency(1234.5)` -> `"$1,234.50"`
  static String currency(
    num? amount, {
    String symbol = '\$',
    int decimalDigits = 2,
    String locale = 'en_US',
  }) {
    if (amount == null) return '${symbol}0.00';
    final format = NumberFormat.currency(
      locale: locale,
      symbol: symbol,
      decimalDigits: decimalDigits,
    );
    return format.format(amount);
  }

  /// Compact numbers for counts, views, likes
  /// Example: `1500` -> `"1.5K"`, `2500000` -> `"2.5M"`
  static String compactNumber(num? number) {
    if (number == null) return '0';
    return NumberFormat.compact().format(number);
  }

  /// Date formatting helper
  /// Example: `AppFormatters.date(dateTime, format: 'MMM dd, yyyy')` -> `"Oct 02, 2026"`
  static String date(DateTime? dateTime, {String format = 'MMM dd, yyyy'}) {
    if (dateTime == null) return '';
    return DateFormat(format).format(dateTime);
  }

  /// Time formatting helper
  /// Example: `AppFormatters.time(dateTime)` -> `"04:30 PM"`
  static String time(DateTime? dateTime, {bool is24Hour = false}) {
    if (dateTime == null) return '';
    final pattern = is24Hour ? 'HH:mm' : 'hh:mm a';
    return DateFormat(pattern).format(dateTime);
  }

  /// Human-readable "Time Ago" helper
  /// Example: `"5 mins ago"`, `"2 days ago"`, `"Just now"`
  static String timeAgo(DateTime? dateTime) {
    if (dateTime == null) return '';
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 45) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      final mins = difference.inMinutes;
      return '$mins ${mins == 1 ? 'min' : 'mins'} ago';
    } else if (difference.inHours < 24) {
      final hours = difference.inHours;
      return '$hours ${hours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inDays < 7) {
      final days = difference.inDays;
      return '$days ${days == 1 ? 'day' : 'days'} ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    } else {
      final years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    }
  }

  /// Formats phone numbers dynamically
  /// Example: `"1234567890"` -> `"(123) 456-7890"`
  static String formatPhone(String phone) {
    final cleaned = phone.replaceAll(RegExp(r'\D'), '');
    if (cleaned.length == 10) {
      return '(${cleaned.substring(0, 3)}) ${cleaned.substring(3, 6)}-${cleaned.substring(6)}';
    }
    return phone;
  }
}
