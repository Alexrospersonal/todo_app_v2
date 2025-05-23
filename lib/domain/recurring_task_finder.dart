import 'package:todo_app_v2/domain/reccuring_task_dto.dart';
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

  Future<ReccuringTaskDto?> _returnTaskIfHasNoNearestCopy(
    TaskEntity task,
  ) async {
    final nearestDate = getNearestDate(task.taskDate!, task.repeatDuringWeek!);

    final copyOfTask = await _taskRepository.getCopyOfTheOriginalTaskByDate(
      nearestDate,
      task.id,
    );

    return copyOfTask == null
        ? ReccuringTaskDto(
            recurringTask: task,
            nextDate: nearestDate,
          )
        : null;
  }

  DateTime getNearestDate(DateTime taskDate, List<int> weekdays) {
    final now = DateTime.now();
    final nearestWeekday = getNearestWeekday(weekdays);
    final daysToAdd = (7 - now.weekday + nearestWeekday) % 7;

    final nextDate = now.add(Duration(days: daysToAdd)).copyWith(
          hour: taskDate.hour,
          minute: taskDate.minute,
        );

    final differenceWithTaskAndNextDates = nextDate.difference(taskDate);

    final nearestDate = taskDate.add(differenceWithTaskAndNextDates);

    return nearestDate;
  }

  int getNearestWeekday(List<int> weekdays) {
    final now = DateTime.now();
    final currentWeekday = now.weekday;

    final nextWeekday = weekdays.firstWhere(
      (weekday) => weekday >= currentWeekday,
      orElse: () => weekdays.first,
    );

    return nextWeekday;
  }
}
