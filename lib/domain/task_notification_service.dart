import 'dart:ui';

import 'package:todo_app_v2/common/utils/navigation.dart';
import 'package:todo_app_v2/domain/notification_service.dart';
import 'package:todo_app_v2/edit_task/models/reminder_time.dart';
import 'package:todo_app_v2/l10n/l10n.dart';
import 'package:todos_repository/todos_repository.dart';

class TaskNotificationData {
  const TaskNotificationData({
    required this.id,
    required this.title,
    required this.body,
    this.route = RouteNames.home,
    this.schedulteTime,
  });

  final int id;
  final String title;
  final String body;
  final DateTime? schedulteTime;
  final RouteNames route;
}

class TaskNotificationService {
  const TaskNotificationService();

  Future<void> updateNotification(
    TaskEntity task,
    ReminderTime notificationReminderTime,
  ) async {
    if (_isNotNotification(task, notificationReminderTime) ||
        _isPrevNotificationExist(task)) {
      await NotificationService.cancelNotification(task.notificationId!);
    }

    final taskNotificationData =
        await _buildTaskNotificationDto(task, notificationReminderTime);

    if (taskNotificationData != null) {
      await _startScheduledNotification(taskNotificationData);
    }
  }

  Future<TaskNotificationData?> _buildTaskNotificationDto(
    TaskEntity task,
    ReminderTime notificationReminderTime,
  ) async {
    if (notificationReminderTime != ReminderTime.none) {
      final locale = PlatformDispatcher.instance.locale;
      final localizations = await AppLocalizations.delegate.load(locale);

      return TaskNotificationData(
        id: task.notificationId!,
        title: localizations.reminderTitle,
        body: task.title,
        schedulteTime: task.taskDate!
            .subtract(Duration(minutes: task.notificationReminderTime!)),
      );
    }
    return null;
  }

  bool _isNotNotification(
    TaskEntity task,
    ReminderTime notificationReminderTime,
  ) =>
      task.notificationId != null &&
      notificationReminderTime == ReminderTime.none;

  bool _isPrevNotificationExist(TaskEntity task) =>
      task.notificationId != null &&
      task.notificationReminderTime != null &&
      task.notificationReminderTime! > 0;

  Future<void> _startScheduledNotification(TaskNotificationData data) async {
    await NotificationService.showNotification(
      data.id,
      data.title,
      data.body,
      data.schedulteTime!,
      data.route,
    );
  }

  Future<void> cancelAllNotification(List<int> ids) async {
    for (final id in ids) {
      await NotificationService.cancelNotification(id);
    }
  }
}
