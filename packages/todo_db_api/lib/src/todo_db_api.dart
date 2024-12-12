import 'package:isar/isar.dart';
import 'package:todo_db_api/src/models/category.dart';
import 'package:todo_db_api/src/models/task.dart';

class TodoDbApi {
  const TodoDbApi({required this.plugin});

  final Isar plugin;

  Stream<List<TaskEntity>> getTasksByCategory(CategoryEntity category) {
    return plugin.taskEntitys
        .filter()
        .colorEqualTo(category.id)
        .watch(fireImmediately: true);
  }

  Future<bool> deleteTask(int id) async {
    return plugin.taskEntitys.delete(id);
  }

  Future<int> creatTask(TaskEntity task) async {
    late int id;

    await plugin.writeTxn(() async {
      id = await plugin.taskEntitys.put(task);
      await task.category.save();
    });

    return id;
  }
}
