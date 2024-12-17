import 'package:flutter/material.dart';
import 'package:todo_app_v2/app/app.dart';
import 'package:todo_app_v2/bootstrap.dart';
import 'package:todos_repository/todos_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isar = await IsarProvider.init();

  if (await isar.categoryEntitys.count() == 0) {
    await isar.writeTxn(
      () async {
        final home = CategoryEntity(name: 'HOME', emoji: '🏠');
        final gym = CategoryEntity(name: 'GYM', emoji: '🏋🏼');
        await isar.categoryEntitys.putAll([home, gym]);
      },
    );
  }

  await bootstrap(
    () => App(
      taskRepository: TodosRepository(todoApi: TodoDbApi(plugin: isar)),
    ),
  );
}
