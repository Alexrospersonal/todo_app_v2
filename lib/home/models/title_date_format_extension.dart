import 'package:intl/intl.dart';

extension DateFomatX on DateFormat {
  String formatDateForTitle(DateTime date) {
    final dayOfYear =
        int.parse(DateFormat('d').format(date)); // Номер дня в році
    final shortWeekday = DateFormat('E')
        .format(date)
        .toUpperCase(); // День тижня (наприклад, mon)
    final shortMonth = DateFormat('MMM')
        .format(date)
        .toUpperCase(); // Назва місяця (наприклад, jan)

    return '$shortWeekday $dayOfYear $shortMonth';
  }
}
