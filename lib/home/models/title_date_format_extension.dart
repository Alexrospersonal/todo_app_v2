import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateFomatX on DateFormat {
  String formatDateForTitle(BuildContext context, DateTime date) {
    final locale = Localizations.localeOf(context);
    final formatter = DateFormat('E d MMM', locale.languageCode);

    return formatter.format(date).toUpperCase();
  }
}
