import 'package:todos_repository/todos_repository.dart';

enum TasksFilters { all, isComing, important, dateless, withDate }

extension TaskEntityX on TasksFilters {
  bool apply(TaskEntity task) {
    switch (this) {
      case TasksFilters.isComing:
        return task.taskDate != null && task.taskDate!.isAfter(DateTime.now());
      case TasksFilters.important:
        return task.important;
      case TasksFilters.dateless:
        return task.taskDate == null || false;
      case TasksFilters.all:
        return true;
      case TasksFilters.withDate:
        return task.taskDate != null;
    }
  }

  Iterable<TaskEntity> applyAll(Iterable<TaskEntity> todos) {
    return todos.where(apply);
  }
}
