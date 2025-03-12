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
    final orinalTask = task.isCopy ? await getOriginalTaskByCopy(task) : null;

    final updatedTask = _copyDataFromStateToTask(
      orinalTask ?? task,
      state,
      notate,
    );

    await _todosRepository.creatTask(updatedTask);

    //TODO: додати провірку чи завдання редаговане
    if (!updatedTask.hasRepeats) {
      await _taskNotificationService.updateNotification(
        updatedTask,
        state.notificationReminderTime,
      );
    }

    // TODO: якщо були внесені зміни то видалити старії копії які ще не завершені та їх сповіщення

    if (updatedTask.hasRepeats) {
      await _buildReccuringTasks(updatedTask, _todosRepository);
    }
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
