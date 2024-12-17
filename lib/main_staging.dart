import 'package:flutter/material.dart';
import 'package:todo_app_v2/app/app.dart';
import 'package:todo_app_v2/bootstrap.dart';
import 'package:todos_repository/todos_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isar = await IsarProvider.init();
  await bootstrap(
    () => App(
      taskRepository: TodosRepository(todoApi: TodoDbApi(plugin: isar)),
    ),
  );
}
