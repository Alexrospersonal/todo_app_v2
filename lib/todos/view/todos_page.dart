import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_v2/l10n/l10n.dart';
import 'package:todo_app_v2/todos/bloc/todos_bloc.dart';
import 'package:todo_app_v2/todos/widgets/widgets.dart';
import 'package:todos_repository/todos_repository.dart';

class TodosPage extends StatelessWidget {
  const TodosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocProvider(
      create: (context) => TodosBloc(
        todosRepository: context.read<TodosRepository>(),
      )..add(const TodosSubscriptionRequested()),
      child: MultiBlocListener(
        listeners: [
          BlocListener<TodosBloc, TodosState>(
            listenWhen: (previous, current) =>
                previous.lastDeletedTodo != current.lastDeletedTodo &&
                current.lastDeletedTodo != null,
            listener: (context, state) {
              final deletedTask = state.lastDeletedTodo!;
              final messenger = ScaffoldMessenger.of(context);
              messenger
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    elevation: 1,
                    behavior: SnackBarBehavior.floating,
                    content: Text(
                      l10n.taskUndoDeletionMessage(deletedTask.title),
                    ),
                    action: SnackBarAction(
                      label: l10n.taskUndoDeletionButtonText,
                      onPressed: () {
                        messenger.hideCurrentSnackBar();
                        context.read<TodosBloc>().add(
                              const TodosUndoDeletionRequested(),
                            );
                      },
                    ),
                  ),
                );
            },
          ),
        ],
        child: const TodosView(),
      ),
    );
  }
}

class TodosView extends StatefulWidget {
  const TodosView({super.key});

  @override
  State<TodosView> createState() => _TodosViewState();
}
// TODO: додати нормальне відображення списків з врахуванням помилок і загруззок в Блок з уроку.
// TODO: додати можливість згорати списки та додати тайтр для DONE та OVERDUE
// TODO: додати відображення списків з виконаними та протермінованими
// TODO: додати завершення та видалення завдань. видалення через свайп.
// TODO: додати можлиавіть повернути видаене завдання.

// TODO: додати можливітьс фільтрувати списки
// TODO: додати відображення категорій із бази даних та додати зміну категорій.

// TODO: написати логіку для статусу та відображення статистики.
class _TodosViewState extends State<TodosView> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        UserStatusBar(),
        TodoProgressBar(),
        TodosCategories(),
        TodosFilters(),
        TodosList(),
      ],
    );
  }
}
