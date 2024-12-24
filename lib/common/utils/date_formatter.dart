import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class DateFormatter {
  static String formatNumberToWeekdays(
    BuildContext context,
    List<int> repeatDuringWeek,
  ) {
    final locale = Localizations.localeOf(context);
    final formatter = DateFormat('E', locale.languageCode);

    return repeatDuringWeek.map((day) {
      final date = DateTime(2024, 1, day);
      return formatter.format(date);
    }).join(' ');
  }

  static String formatDateTimesToTimeString(List<DateTime> repeatDuringDay) {
    return repeatDuringDay.map((day) {
      return '${day.hour}:${day.minute}';
    }).join(' ');
  }

  static String formatDateTime(BuildContext context, DateTime? date) {
    if (date == null) {
      return '';
    }

    final locale = Localizations.localeOf(context);
    final formatter = DateFormat('dd MMMM yyyy HH:mm', locale.languageCode);
    return formatter.format(date);
  }
}
