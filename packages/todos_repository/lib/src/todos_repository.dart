import 'package:todo_db_api/todo_db_api.dart';

/// {@template todos_repository}
/// A repository that handles todo related requests.
/// {@endtemplate}
class TodosRepository {
  /// {@macro todos_repository}
  const TodosRepository({required this.todoApi});

  ///
  final TodoDbApi todoApi;

  ///
  Stream<List<TaskEntity>> getTasksByCategory(CategoryEntity? category) {
    if (category != null) {
      return todoApi.getTasksByCategory(category);
    }

    return todoApi.getAllTasks();
  }

  ///
  Stream<List<TaskEntity>> getAllTasks() {
    final stream = todoApi.getAllTasks();
    return stream;
  }

  ///
  Stream<List<CategoryEntity>> getCategoriesStream() {
    return todoApi.getCategoriesStream();
  }

  ///
  Future<bool> deleteTask(int id) async => todoApi.deleteTask(id);

  ///
  Future<int> creatTask(TaskEntity task) async => todoApi.creatTask(task);

  ///
  Future<List<CategoryEntity>> getAllCategories() async =>
      todoApi.getAllCategories();

  ///
  Future<void> createCategory(String title) async =>
      todoApi.createCategory(title);

  /// Checks if there are any tasks that are overdue.
  ///
  /// This function iterates through the list of tasks
  /// and determines if any of them have a due date that is before the current
  /// date and time. If at least one overdue task is found,
  /// the function returns `true`; otherwise, it returns `false`.
  Future<bool> hasOverdueTasks(CategoryEntity? category) async =>
      todoApi.hasOverdueTasks(category);

  ///
  Future<List<TaskEntity>> getRecurringTasks() async =>
      todoApi.getRecurringTasks();

  ///
  Future<TaskEntity?> getCopyOfTheOriginalTaskByDate(
    DateTime taskDate,
    int orinalTaskId,
  ) =>
      todoApi.getCopyOfTheOriginalTaskByDate(taskDate, orinalTaskId);

  ///
  Future<void> saveRecurringTask(
    TaskEntity recurringTask,
    TaskEntity originalTask,
  ) async =>
      todoApi.saveRecurringTask(recurringTask, originalTask);

  ///
  Future<TaskEntity?> getOriginalTaskByCopy(TaskEntity taskCopy) =>
      todoApi.getOriginalTaskByCopy(taskCopy);
}
