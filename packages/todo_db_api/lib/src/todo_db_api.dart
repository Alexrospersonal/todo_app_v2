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
    final stream = plugin.taskEntitys
        .filter()
        .isFinishedEqualTo(false)
        .watch(fireImmediately: true);

    return stream;
  }

  Future<bool> deleteTask(int id) async {
    late bool result;

    await plugin.writeTxn(() async {
      result = await plugin.taskEntitys.delete(id);
    });
    return result;
  }

  Future<int> creatTask(TaskEntity task) async {
    late int id;

    await plugin.writeTxn(() async {
      id = await plugin.taskEntitys.put(task);
      await task.category.save();
    });

    return id;
  }

  Future<List<CategoryEntity>> getAllCategories() async {
    return plugin.categoryEntitys.where().findAll();
  }
}
