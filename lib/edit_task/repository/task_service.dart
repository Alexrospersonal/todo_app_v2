import 'package:todo_app_v2/domain/recurring_task_builder.dart';
import 'package:todo_app_v2/domain/recurring_task_finder.dart';
import 'package:todo_app_v2/domain/task_notification_service.dart';
import 'package:todo_app_v2/edit_task/bloc/edit_task_bloc.dart';
import 'package:todos_repository/todos_repository.dart';
import 'package:uuid/uuid.dart';

class TaskService {
  const TaskService({
    required TodosRepository todosRepository,
    required RecurringTaskFinder recurringTaskFinder,
    required RecurringTaskBuilder recurringTaskBuilder,
    required TaskNotificationService taskNotificationService,
  })  : _todosRepository = todosRepository,
        _recurringTaskFinder = recurringTaskFinder,
        _recurringTaskBuilder = recurringTaskBuilder,
        _taskNotificationService = taskNotificationService;

  final TodosRepository _todosRepository;
  final RecurringTaskFinder _recurringTaskFinder;
  final RecurringTaskBuilder _recurringTaskBuilder;
  final TaskNotificationService _taskNotificationService;

  Future<void> buildTask(
    TaskEntity task,
    EditTaskState state,
    String notate,
  ) async {
    final originalTask = task.isCopy ? await getOriginalTaskByCopy(task) : null;

    final updatedTask = _copyDataFromStateToTask(
      originalTask ?? task,
      state,
      notate,
    );

    await _todosRepository.creatTask(updatedTask);

    if (!updatedTask.hasRepeats) {
      await _taskNotificationService.updateNotification(
        updatedTask,
        state.notificationReminderTime,
      );
    }

    if (originalTask != null) {
      await _removeCopiesOfTaskAndCancelTheirNotification(originalTask);
    }

    if (updatedTask.hasRepeats) {
      await _buildReccuringTasks(updatedTask, _todosRepository);
    }
  }

  Future<void> _removeCopiesOfTaskAndCancelTheirNotification(
      TaskEntity originalTask) async {
    final copiesOfOriginalTask =
        await _todosRepository.getCopiesOfTaskByOriginalTaskId(originalTask.id);

    final notificationIdList = _getNotificationsIds(copiesOfOriginalTask);

    await _removeCopiesOfTask(originalTask);
    await _taskNotificationService.cancelAllNotification(notificationIdList);
  }

  Future<TaskEntity?> getOriginalTaskByCopy(TaskEntity task) async {
    return _todosRepository.getOriginalTaskByCopy(task);
  }

  TaskEntity _copyDataFromStateToTask(
    TaskEntity task,
    EditTaskState state,
    String notate,
  ) {
    final copyOfTask = task.copyWith(
      id: task.id,
      title: state.title,
      notate: notate,
      color: state.color,
      important: state.important,
      taskDate: state.taskDate,
      hasTime: state.hasTime,
      hasRepeats: state.hasRepeats,
      repeatDuringWeek: state.repeatDuringWeek,
      repeatDuringDay: state.repeatDuringDay,
      endDateOfRepeatedly: state.endDateOfRepeatedly,
      notificationReminderTime: state.notificationReminderTime.minutes,
      notificationId: const Uuid().v4().hashCode,
    );

    copyOfTask.category.value = state.category;

    if (state.subtasks.isNotEmpty) {
      copyOfTask.subtasks = state.subtasks;
    }

    return copyOfTask;
  }

  List<int> _getNotificationsIds(List<TaskEntity> tasks) {
    return tasks
        .where((task) => task.notificationId != null)
        .map((task) => task.id)
        .toList();
  }

  Future<void> _removeCopiesOfTask(TaskEntity originalTask) async {
    final copies =
        await _todosRepository.getCopiesOfTaskByOriginalTaskId(originalTask.id);

    final copiesId = copies.map((task) => task.id);

    await _todosRepository.deleteTasks(copiesId.toList());
  }

  Future<void> _buildReccuringTasks(
    TaskEntity task,
    TodosRepository todosRepository,
  ) async {
    final nearestDate = _recurringTaskFinder.getNearestDate(
      task.taskDate!,
      task.repeatDuringWeek!,
    );

    await _recurringTaskBuilder.buildReccuringTask(task, nearestDate);
  }
}
