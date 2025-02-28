import 'package:todo_app_v2/domain/task_notification_service.dart';
import 'package:todo_app_v2/edit_task/models/reminder_time.dart';
import 'package:todos_repository/todos_repository.dart';
import 'package:uuid/uuid.dart';

class RecurringTaskBuilder {
  const RecurringTaskBuilder({
    required TodosRepository todosRepository,
    required TaskNotificationService taskNotificationService,
  })  : _taskRepository = todosRepository,
        _taskNotificationService = taskNotificationService;

  final TodosRepository _taskRepository;
  final TaskNotificationService _taskNotificationService;

  Future<void> buildReccuringTask(TaskEntity task, DateTime nextDate) async {
    final reccuringTask = task.copyWith(
      isCopy: true,
      taskDate: nextDate,
      notificationId: const Uuid().v4().hashCode,
    );
    await _taskRepository.saveRecurringTask(reccuringTask, task);

    await _taskNotificationService.updateNotification(
      reccuringTask,
      ReminderTime.fromMinutes(task.notificationReminderTime),
    );
  }
}
