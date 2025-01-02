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
    this.isOpenCreateCategory = false,
  });

  final TodosOverviewStatus status;
  final List<TaskEntity> todos;
  final TasksFilters filter;
  final CategoryEntity? selectedCategory;
  final TaskEntity? lastDeletedTodo;
  final List<CategoryEntity> categories;
  final bool isOpenCreateCategory;

  Iterable<TaskEntity> get filteredTodos => filter.applyAll(todos);

  TodosState copyWith({
    TodosOverviewStatus Function()? status,
    List<TaskEntity> Function()? todos,
    List<CategoryEntity> Function()? categories,
    TasksFilters Function()? filter,
    TaskEntity? Function()? lastDeletedTodo,
    CategoryEntity? Function()? selectedCategory,
    bool Function()? isOpenCreateCategory,
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
      isOpenCreateCategory: isOpenCreateCategory != null
          ? isOpenCreateCategory()
          : this.isOpenCreateCategory,
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
        isOpenCreateCategory,
      ];
}
