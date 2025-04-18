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
    this.taskOverdueCount = 0,
  });

  final TodosOverviewStatus status;
  final List<TaskEntity> todos;
  final TasksFilters filter;
  final CategoryEntity? selectedCategory;
  final TaskEntity? lastDeletedTodo;
  final List<CategoryObject> categories;
  final bool isOpenCreateCategory;
  final int taskOverdueCount;

  Iterable<TaskEntity> get filteredTodos => filter.applyAll(todos);

  Iterable<TaskEntity> get newTodos => filteredTodos.where((task) {
        if (!task.isFinished && task.taskDate == null) {
          return true;
        } else if (!task.isFinished && task.taskDate!.isAfter(DateTime.now())) {
          if (task.hasRepeats && !task.isCopy) {
            return false;
          }
          return true;
        } else {
          return false;
        }
      });

  Iterable<TaskEntity> get finishedTodos =>
      filteredTodos.where((task) => task.isFinished);

  Iterable<TaskEntity> get overdueTodos => filteredTodos.where(
        (task) =>
            task.taskDate != null &&
            task.isFinished == false &&
            task.taskDate!.isBefore(
              DateTime.now(),
            ),
      );

  TodosState copyWith({
    TodosOverviewStatus Function()? status,
    List<TaskEntity> Function()? todos,
    List<CategoryObject> Function()? categories,
    TasksFilters Function()? filter,
    TaskEntity? Function()? lastDeletedTodo,
    CategoryEntity? Function()? selectedCategory,
    bool Function()? isOpenCreateCategory,
    int? taskOverdueCount,
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
      taskOverdueCount: taskOverdueCount ?? this.taskOverdueCount,
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
        taskOverdueCount
      ];
}
