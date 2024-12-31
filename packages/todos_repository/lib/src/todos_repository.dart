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
}
