part of 'todos_bloc.dart';

enum TodosOverviewStatus { initial, loading, success, failure }

final class TodosState extends Equatable {
  const TodosState({
    this.status = TodosOverviewStatus.initial,
    this.todos = const <TaskEntity>[],
    this.filter = TasksFilters.all,
    this.lastDeletedTodo,
  });

  final TodosOverviewStatus status;
  final List<TaskEntity> todos;
  final TasksFilters filter;
  final TaskEntity? lastDeletedTodo;

  Iterable<TaskEntity> get filteredTodos => filter.applyAll(todos);

  TodosState copyWith({
    TodosOverviewStatus Function()? status,
    List<TaskEntity> Function()? todos,
    TasksFilters Function()? filter,
    TaskEntity? Function()? lastDeletedTodo,
  }) {
    return TodosState(
      status: status != null ? status() : this.status,
      todos: todos != null ? todos() : this.todos,
      filter: filter != null ? filter() : this.filter,
      lastDeletedTodo:
          lastDeletedTodo != null ? lastDeletedTodo() : this.lastDeletedTodo,
    );
  }

  @override
  List<Object?> get props => [
        status,
        todos,
        filter,
        lastDeletedTodo,
      ];
}
