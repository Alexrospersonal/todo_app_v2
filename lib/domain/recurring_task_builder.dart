import 'package:todos_repository/todos_repository.dart';

class RecurringTaskBuilder {
  const RecurringTaskBuilder({required TodosRepository todosRepository})
      : _taskRepository = todosRepository;

  final TodosRepository _taskRepository;

  Future<void> buildReccuringTask(TaskEntity task, DateTime nextDate) async {
    final reccuringTask = task.copyWith(isCopy: true, taskDate: nextDate);
    await _taskRepository.saveRecurringTask(reccuringTask, task);
  }
}
