import 'package:isar/isar.dart';
import 'package:todo_db_api/src/models/category.dart';
import 'package:todo_db_api/src/models/task.dart';

class TodoDbApi {
  const TodoDbApi({required this.plugin});

  final Isar plugin;

  Stream<List<TaskEntity>> getTasksByCategory(CategoryEntity category) {
    return plugin.taskEntitys
        .filter()
        .category((cat) => cat.idEqualTo(category.id))
        .watch(fireImmediately: true);
  }

  Stream<List<TaskEntity>> getAllTasks() {
    final stream = plugin.taskEntitys.where().watch(fireImmediately: true);

    return stream;
  }

  Stream<List<CategoryEntity>> getCategoriesStream() {
    final stream = plugin.categoryEntitys.where().watch(fireImmediately: true);

    return stream;
  }

  Future<bool> deleteTask(int id) async {
    late bool result;

    await plugin.writeTxn(() async {
      result = await plugin.taskEntitys.delete(id);
    });
    return result;
  }

  Future<int> deleteTasks(List<int> ids) async {
    late int deletedResult;

    await plugin.writeTxn(() async {
      deletedResult = await plugin.taskEntitys.deleteAll(ids);
    });

    return deletedResult;
  }

  Future<List<TaskEntity>> getCopiesOfTaskByOriginalTaskId(int id) async {
    return plugin.taskEntitys
        .filter()
        .originalTask((q) => q.idEqualTo(id))
        .findAll();
  }

  Future<int> creatTask(TaskEntity task) async {
    late int id;

    if (task.category.value?.id != null) {
      final id = task.category.value!.id;
      final existingCategory = await plugin.categoryEntitys.get(id);

      if (existingCategory != null) {
        task.category.value = existingCategory;
      }
    }

    await plugin.writeTxn(() async {
      id = await plugin.taskEntitys.put(task);
      await task.category.save();
    });

    return id;
  }

  Future<List<CategoryEntity>> getAllCategories() async {
    return plugin.categoryEntitys.where().findAll();
  }

  Future<void> createCategory(String title) async {
    final category = CategoryEntity(name: title);

    await plugin.writeTxn(() async {
      await plugin.categoryEntitys.put(category);
    });
  }

  /// Checks if there are overdue tasks.
  /// If [category] is provided, only tasks in this category are checked.
  Future<bool> hasOverdueTasks(CategoryEntity? category) async {
    var query = plugin.taskEntitys
        .filter()
        .isFinishedEqualTo(false)
        .taskDateIsNotNull()
        .taskDateLessThan(DateTime.now());

    if (category != null) {
      query = query.category((q) => q.idEqualTo(category.id));
    }

    final overdueTask = await query.findFirst();

    return overdueTask != null;
  }

  Future<List<TaskEntity>> getRecurringTasks() async {
    return plugin.taskEntitys
        .filter()
        .isFinishedEqualTo(false)
        .taskDateIsNotNull()
        .taskDateGreaterThan(DateTime.now())
        .hasRepeatsEqualTo(true)
        .findAll();
  }

  Future<TaskEntity?> getCopyOfTheOriginalTaskByDate(
    DateTime taskDate,
    int orinalTaskId,
  ) {
    return plugin.taskEntitys
        .filter()
        .isFinishedEqualTo(false)
        .isCopyEqualTo(true)
        .taskDateEqualTo(taskDate)
        .originalTask((q) => q.idEqualTo(orinalTaskId))
        .findFirst();
  }

  Future<void> saveRecurringTask(
    TaskEntity recurringTask,
    TaskEntity originalTask,
  ) async {
    await plugin.writeTxn(() async {
      await originalTask.category.load();

      recurringTask.category.value = originalTask.category.value;
      recurringTask.originalTask.value = originalTask;

      await plugin.taskEntitys.put(recurringTask);
      await recurringTask.category.save();
    });
  }

  Future<TaskEntity?> getOriginalTaskByCopy(TaskEntity taskCopy) async {
    await taskCopy.originalTask.load();
    return taskCopy.originalTask.value;
  }
}
