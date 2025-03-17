import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:todo_app_v2/app/app.dart';
import 'package:todo_app_v2/bootstrap.dart';
import 'package:todo_app_v2/domain/notification_service.dart';
import 'package:todo_app_v2/domain/recurring_task_builder.dart';
import 'package:todo_app_v2/domain/recurring_task_finder.dart';
import 'package:todo_app_v2/domain/task_notification_service.dart';
import 'package:todos_repository/todos_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await NotificationService.init();
  tz.initializeTimeZones();

  final isar = await IsarProvider.init();

  if (await isar.categoryEntitys.count() == 0) {
    await isar.writeTxn(
      () async {
        final home = CategoryEntity(name: 'HOME', emoji: '🏠');
        final gym = CategoryEntity(name: 'GYM', emoji: '🏋🏼');
        await isar.categoryEntitys.putAll([home, gym]);
      },
    );
  }

  final todosRepository = TodosRepository(todoApi: TodoDbApi(plugin: isar));

  await runOncePerDay(todosRepository);

  await bootstrap(
    () => App(
      taskRepository: todosRepository,
    ),
  );
}

Future<void> runOncePerDay(TodosRepository todosRepository) async {
  final prefs = await SharedPreferences.getInstance();
  final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
  final lastRunDate = prefs.getString('last_run_date');

  if (lastRunDate != today) {
    final recurringTaskFinder =
        RecurringTaskFinder(taskRepository: todosRepository);

    final recurringTaskBuilder = RecurringTaskBuilder(
      todosRepository: todosRepository,
      taskNotificationService: const TaskNotificationService(),
    );

    final tasks =
        await recurringTaskFinder.findRecurringTasksWithoutNearestCopy();

    for (final task in tasks) {
      final nextDate = recurringTaskFinder.getNearestDate(
          task.taskDate!, task.repeatDuringWeek!);
      await recurringTaskBuilder.buildReccuringTask(task, nextDate);
    }

    await prefs.setString('last_run_date', today);
  }
}
