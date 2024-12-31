part of 'todos_bloc.dart';

enum TodosOverviewStatus { initial, loading, success, failure }

final class TodosState extends Equatable {
  const TodosState({
    this.status = TodosOverviewStatus.initial,
    this.todos = const <TaskEntity>[],
    this.selectedCategory,
    this.filter = TasksFilters.all,
    this.lastDeletedTodo,
    this.categories = const [],
  });

  final TodosOverviewStatus status;
  final List<TaskEntity> todos;
  final TasksFilters filter;
  final CategoryEntity? selectedCategory;
  final TaskEntity? lastDeletedTodo;
  final List<CategoryEntity> categories;

  Iterable<TaskEntity> get filteredTodos => filter.applyAll(todos);

  TodosState copyWith({
    TodosOverviewStatus Function()? status,
    List<TaskEntity> Function()? todos,
    List<CategoryEntity> Function()? categories,
    TasksFilters Function()? filter,
    TaskEntity? Function()? lastDeletedTodo,
    CategoryEntity? Function()? selectedCategory,
  }) {
    return TodosState(
      status: status != null ? status() : this.status,
      todos: todos != null ? todos() : this.todos,
      selectedCategory:
          selectedCategory != null ? selectedCategory() : this.selectedCategory,
      categories: categories != null ? categories() : this.categories,
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
        selectedCategory,
        categories,
      ];
}
