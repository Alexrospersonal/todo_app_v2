import 'package:todos_repository/todos_repository.dart';

class RecurringTaskFinder {
  const RecurringTaskFinder({
    required TodosRepository taskRepository,
  }) : _taskRepository = taskRepository;

  final TodosRepository _taskRepository;

  Future<List<TaskEntity>> findRecurringTasksWithoutNearestCopy() async {
    final allRecurringTasks = await _taskRepository.getRecurringTasks();

    final recurringTasksWithoutNearestCopy = await Future.wait(
      allRecurringTasks.map(_returnTaskIfHasNoNearestCopy),
      eagerError: true,
    );

    return recurringTasksWithoutNearestCopy.whereType<TaskEntity>().toList();
  }

  Future<TaskEntity?> _returnTaskIfHasNoNearestCopy(TaskEntity task) async {
    final nearestDate = _getNearestDate(task.taskDate!, task.repeatDuringWeek!);

    final copyOfTask = await _taskRepository.getCopyOfTheOriginalTaskByDate(
      nearestDate,
      task.id,
    );

    return copyOfTask == null ? task : null;
  }

  DateTime _getNearestDate(DateTime taskDate, List<int> weekdays) {
    final now = DateTime.now();
    final daysToAdd = (7 - now.weekday + weekdays.first) % 7;

    final nextDate = now.add(Duration(days: daysToAdd));
    final differenceWithTaskAndNextDates = nextDate.difference(taskDate);

    return taskDate.add(differenceWithTaskAndNextDates);
  }
}
