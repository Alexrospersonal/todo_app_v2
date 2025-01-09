// ignore_for_file: lines_longer_than_80_chars

import 'package:todo_app_v2/l10n/l10n.dart';

enum ReminderTime {
  none(minutes: 0),
  fiveMin(minutes: 5),
  tenMin(minutes: 10),
  twentyFiveMin(minutes: 25),
  oneHour(minutes: 60),
  oneHourAndThreetyMin(minutes: 90),
  twoHourAndThreetyMin(minutes: 150);

  const ReminderTime({required this.minutes});

  final int minutes;

  String formatTime(AppLocalizations l10n) {
    final hours = minutes ~/ 60;
    final remainingMinutes = minutes % 60;

    if (minutes == 0) {
      return l10n.noneTitle;
    }

    if (hours > 0 && remainingMinutes > 0) {
      if (hours == 1) {
        return '${l10n.hourTimeDurationMessage(hours)} ${l10n.minutesTimeDurationMessage(remainingMinutes)}';
      }
      return '${l10n.hoursTimeDurationMessage(hours)} ${l10n.minutesTimeDurationMessage(remainingMinutes)}';
    } else if (hours > 0) {
      if (hours == 1) {
        return l10n.hourTimeDurationMessage(hours);
      }
      return l10n.hoursTimeDurationMessage(hours);
    } else {
      return l10n.inMinutesTimeDurationMessage(remainingMinutes);
    }
  }
}
